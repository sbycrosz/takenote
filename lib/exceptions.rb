module Exceptions
  class ErrorWithDefaultMessage < StandardError
    def initialize(*args)
      msg = args.shift
      msg ||= self.class.default_message
      super(msg, *args)
    end

    def self.default_message(message_text = nil)
      if message_text
        @message_text = message_text
      else
        @message_text
      end
    end
  end

  class NotAuthenticated < ErrorWithDefaultMessage
    default_message "Not Authenticated"
  end
end