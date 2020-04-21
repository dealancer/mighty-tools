# mighty-tools

## iCloud photo converter

### Usage
```
./icloud-photo-conv.sh input-path output-path
```

### Dependencies
* `exiftool`
* `magick`
* `ffmpeg`

Use `homebrew` to install these depdencies.

### Features
* Converts HEIC files to JPG ones.
* Converts MOV files to MP4 ones.
* Preserves metadata.
* Uses creation date as a filename.
* Categorizes files into directories by year and month.


## Duplicates finder

It's very simple script. For a better results, use Duplicate Photos Finder app for MacOS.

### Usage
```
./dupe-finder.sh path
```

### Features
* Finds all duplicated files in the specific path.
* Ignores files that have differnt metadata but same content.
* Scans path recursively.


## Metadata cleaner


### Dependencies
* `exiftool`

Use `homebrew` to install these depdencies.

### Usage
```
./metadata-cleaner.sh path
```

### Features
* Removes all metadata from files in directory.
* Scans path recursively.
