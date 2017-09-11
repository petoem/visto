module Visto
  def self.decode(canvas : Canvas) : Bytes
    raise "Image too small!" if canvas.pixels.size < 8
    size = 0_u64
    size = size | StumpyCore::Utils.scale_from_to(canvas.pixels[7].r, 16, 8).to_u64
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[6].r, 16, 8).to_u64 << 8)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[5].r, 16, 8).to_u64 << 16)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[4].r, 16, 8).to_u64 << 24)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[3].r, 16, 8).to_u64 << 32)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[2].r, 16, 8).to_u64 << 40)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[1].r, 16, 8).to_u64 << 48)
    size = size | (StumpyCore::Utils.scale_from_to(canvas.pixels[0].r, 16, 8).to_u64 << 56)
    data = Bytes.new size
    pixels = canvas.pixels + 8
    data.each_index do |index|
      data[index] = StumpyCore::Utils.scale_from_to(pixels[index].r, 16, 8).to_u8
    end
    data
  end
end
