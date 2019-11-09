# frozen_string_literal: true

class ShortCode
  ALPHABET = '63BTN9Z7tM8jCDqhJPmFn2vYgdfy4p5SrcLXHQkbszWRGwKxV'
  BASE = ALPHABET.length

  def self.encode(int)
		str = ""

		while int > 0 do
			str = ALPHABET[int % BASE] + str
			int /= BASE
		end

		str
	end

	def self.decode(str)
		int = x = 0

		while x < str.length do
			int = int * BASE + ALPHABET.index(str[x])
			x += 1
		end

		int
	end
end