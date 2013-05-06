# IGFastImage

Finds the size and type of an image given its uri by fetching as little as needed.

## The problem

Your app needs to find the size or type of an image. This could be for adding width and height attributes to an image tag, for adjusting layouts or overlays to fit an image or any other of dozens of reasons.

But the image is not locally stored – it’s on another asset server, or in the cloud – at Amazon S3 for example.

You don’t want to download the entire image to your app – it could be many tens of kilobytes, or even megabytes just to get this information. For most image types, the size of the image is simply stored at the start of the file. For JPEG files it’s a little bit more complex, but even so you do not need to fetch much of the image to find the size.

IGFastImage does this minimal fetch for image types GIF, JPEG, PNG and BMP. You only need supply the uri, and IGFastImage will do the rest.

## Examples

```
NSURL* url = [NSURL URLWithString:@"https://www.google.com.hk/images/icons/product/chrome-48.png"];
IGFastImage* image = [[IGFastImage alloc] initWithURL:url];
# image.type => IGFastImageTypePNG
# image.size => CGSizeMake(48.0, 48.0)
```

IGFastImage create HTTP connection in background asynchronously. If the operaion is not complete, it will block if you access type or size.

## Installation

If you use CocoaPods, add following line to your Podfile:

```
pod 'IGFastImage'
```

Otherwise, add files under ```IGFastImage/FastImage/*```, as well as AFNetworking and its dependency to your project.

## References

- [fastimage](https://github.com/sdsykes/fastimage) - IGFastImage is mostly based on fastimage gem

## Licence

MIT, see file LICENSE
