module Visto
  def self.encode(data : Bytes) : Canvas
    canvas_size = Math.sqrt(data.size + 8).ceil.to_i32
    size_bytes = Bytes.new 8
    size = data.size.to_u64
    num = 0_u8
    size_bytes[7] = num | size
    size_bytes[6] = num | (size >> 8)
    size_bytes[5] = num | (size >> 16)
    size_bytes[4] = num | (size >> 24)
    size_bytes[3] = num | (size >> 32)
    size_bytes[2] = num | (size >> 40)
    size_bytes[1] = num | (size >> 48)
    size_bytes[0] = num | (size >> 56)

    canvas = Canvas.new canvas_size, canvas_size do |x, y|
      if x + y * canvas_size < size_bytes.size
        RGBA.from_gray_n size_bytes[x + y * canvas_size], 8
      else
        if (x + y * canvas_size) - 8 < data.size
          RGBA.from_gray_n data[(x + y * canvas_size) - 8], 8
        else
          RGBA.from_gray_n 0, 8
        end
      end
    end
    canvas
  end

  def self.encode_alt(data : Bytes) : Canvas
    canvas_size = Math.sqrt(data.size + 8).ceil.to_i32
    size_bytes = Bytes.new 8
    size = data.size.to_u64
    num = 0_u8
    size_bytes[7] = num | size
    size_bytes[6] = num | (size >> 8)
    size_bytes[5] = num | (size >> 16)
    size_bytes[4] = num | (size >> 24)
    size_bytes[3] = num | (size >> 32)
    size_bytes[2] = num | (size >> 40)
    size_bytes[1] = num | (size >> 48)
    size_bytes[0] = num | (size >> 56)

    canvas = Canvas.new canvas_size, canvas_size, RGBA.from_gray_n(0, 8)
    (pixels_size = canvas.pixels[0, 8]).each_index do |index|
      pixels_size[index] = RGBA.from_gray_n size_bytes[index], 8
    end
    (pixels = canvas.pixels + 8).each_index do |index|
      if byte = data[index]?
        pixels[index] = RGBA.from_gray_n byte, 8
      else
        pixels[index] = RGBA.from_gray_n 0, 8
      end
    end
    canvas
  end
end
