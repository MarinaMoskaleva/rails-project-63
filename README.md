# HexletCode

[![Tests](https://github.com/MarinaMoskaleva/rails-project-63/actions/workflows/main.yml/badge.svg)](https://github.com/MarinaMoskaleva/rails-project-63/actions)

HexletCode is a Ruby gem that provides a form generator, enabling developers to seamlessly construct HTML forms.

## Installation

```
make install
```

## Usage

```
User = Struct.new(:name, :job, keyword_init: true)
user = User.new job: 'hexlet'

HexletCode.form_for user do |f|
  f.input :name
  f.input :job
  f.submit
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
#   <input type="submit" value="Save">
# </form>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MarinaMoskaleva/rails-project-63.
