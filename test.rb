# frozen_string_literal: true

require_relative "lib/hexlet_code"

p HexletCode::Tag.build("br")
p HexletCode::Tag.build("img", src: "path/to/image")
p HexletCode::Tag.build("input", type: "submit", value: "Save")
# <input type="submit" value="Save">

# Для парных тегов тело передается как блок
p HexletCode::Tag.build("label") { "Email" }
# <label>Email</label>

p HexletCode::Tag.build("label", for: "email") { "Email" }
# <label for="email">Email</label>

p HexletCode::Tag.build("div")
