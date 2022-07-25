require_relative "./post.rb"

class Image < Post
  FORMAT_CODE = "IMG".freeze

  BUNDLES = {
    5 => 450,
    10 => 800
  }.freeze
end
