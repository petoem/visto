# visto

[![Travis](https://img.shields.io/travis/petoem/visto.svg?style=flat-square)](https://travis-ci.org/petoem/visto)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/petoem/visto/blob/master/LICENSE) 

visto (**Vis**ual **Sto**rage) allows you to store `Bytes` as an image. 

## Build

```
> crystal build src/cli.cr --release -o visto
```

## Usage

```
> visto --help
Usage: visto [FILE] [arguments]
    -e, --encode                     Encode data into image
    -d, --decode                     Decode data from image
    -o FILE, --output=FILE           Specifies the output file path
    -v, --version                    Show version number
    -h, --help                       Show this help
> 
> # to store a file as an image, run ...
> visto myawesome.pdf -e -o image.png
> # to get your file ...
> visto image.png -d -o my.pdf
```

## Example

<img src="example.png" width="150">

> The file [random.txt](spec/random.txt) as an image.

Each pixel corresponds to a byte.
Bytes are written from left to right, top to bottom.

The first 8 pixels represents a `UInt64` number, which tells how many bytes long the stored data is. 
After this data pixels follow. Any excess pixels at the end are filled up with black.

## Contributing

1. Fork it ( https://github.com/petoem/visto/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [petoem](https://github.com/petoem) Michael Petö - creator, maintainer
