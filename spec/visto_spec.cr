require "./spec_helper"

describe Visto do
  it "encode" do
    io = File.open "spec/random.txt", "r"
    data = Bytes.new io.size
    io.read_fully data
    canvas = Visto.encode_alt data
    StumpyPNG.write canvas, "spec/spec_image.png", bit_depth: 16, color_type: :grayscale
  end

  it "decode" do
    canvas = StumpyPNG.read "spec/spec_image.png"
    data = Visto.decode canvas
    File.write "spec/spec_data.txt", data
  end

  it "verify files" do
    `sha256sum spec/spec_data.txt | awk '{ print $1 }'`.should eq(`sha256sum spec/random.txt | awk '{ print $1 }'`)
  end
end
