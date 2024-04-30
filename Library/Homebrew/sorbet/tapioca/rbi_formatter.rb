# typed: strict
# frozen_string_literal: true

# It doesn't work to add this in pre- or post-require, instead we need to require this from the compilers :(
# Attempted to upstream in https://github.com/Shopify/tapioca/pull/1885

module Tapioca
  class RBIFormatter < RBI::Formatter
    alias_method :old_write_header!, :write_header!

    extend T::Sig
    sig do
      params(
        file: RBI::File,
        command: String,
        reason: T.nilable(String),
      ).void
    end
    def write_header!(file, command, reason: nil)
      old_write_header!(file, command, reason:)
      # Prevent the header from being attached to the top-level node when generating YARD docs
      file.comments << RBI::BlankLine.new
    end
  end
end
