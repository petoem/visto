require "./visto"
require "option_parser"

in_file_path = nil
out_file_path = nil
decode = false

OptionParser.parse! do |parser|
  parser.banner = "Usage: visto [FILE] [arguments]"
  parser.on("-e", "--encode", "Encode data into image") { decode = false }
  parser.on("-d", "--decode", "Decode data from image") { decode = true }
  parser.on("-o FILE", "--output=FILE", "Specifies the output file path") { |output| out_file_path = output }
  parser.on("-v", "--version", "Show version number") do
    puts Visto::VERSION
    exit
  end
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.unknown_args { |unknown_args| in_file_path = unknown_args[0] unless unknown_args.empty? }
end

if in_file_path
  if decode
    unless out_file_path
      puts "No output file specified!"
      exit
    end
    canvas = StumpyPNG.read in_file_path.as String
    data = Visto.decode canvas
    File.write out_file_path.as String, data
  else
    io = File.open in_file_path.as String, "r"
    data = Bytes.new io.size
    io.read_fully data
    canvas = Visto.encode_alt data
    out_file_path = "out.png" unless out_file_path
    StumpyPNG.write canvas, out_file_path.as String, bit_depth: 16, color_type: :grayscale
  end
else
  puts "No input file specified!"
end
