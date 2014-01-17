require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  # Attributes here
end

Note.blueprint do
  # Attributes here
end

Tag.blueprint do
  # Attributes here
end

NoteTag.blueprint do
  # Attributes here
end
