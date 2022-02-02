# OJXV: Open Journals XML Validator

OJXV validates Open Journals' publishing pipeline XML outputs (JATS and Crossref).

## Installation

```
gem install ojxv
```

## Usage

OJXV can be used to validate JATS and Crossref XML files against the following schema versions:

- JATS:
  - 1.1
  - 1.1d1
  - 1.1d2
  - 1.1d3
  - 1.2
  - 1.2d1
  - 1.2d2
  - 1.3d1
  - 1.3
- Crossref:
  - 4.8.0
  - 4.8.1
  - 5.1.0
  - 5.2.0
  - 5.3.0
  - 5.3.1

### Validating JATS files

```ruby
require "ojxv"

jats_file_path = "example/paper.jats"

jats_file = OJXV::JatsFile.new(jats_file_path)

# By default validation is performed against JATS v1.3
jats_file.valid_jats? #=> true / false

# Validating against a specific schema version:
jats_file.valid_jats?("1.2") #=> true / false

# After validating, errors can be queried:
jats_file.errors #=> [] / ["Error: missing element article", "Error: invalid namespace", ...]
```

### Validating Crossref XML files

```ruby
require "ojxv"

crossref_file_path = "example/paper.crossref"

crossref_file = OJXV::CrossrefMetadataFile.new(crossref_file_path)

# By default validation is performed against Crossref 5.3.1
crossref_file.valid_crossref? #=> true / false

# Validating against a specific schema version:
crossref_file.valid_crossref?("4.8.0") #=> true / false

# After validating, errors can be queried:
crossref_file.errors #=> [] / ["Error: missing element article", "Error: invalid namespace", ...]
```

## License

Released under a [MIT License](./LICENSE) - &copy; Juanjo Bazán