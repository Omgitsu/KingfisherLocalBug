# KingfisherLocalBug

In Kingfisher 4.0 you could load images from the local disk without needed a provider.  
In Kingfisher 5.0 attempting to load from the disk without a provider will give you an error stating 
`load failed with error Error Domain=NSURLErrorDomain Code=-999 "cancelled"...`

while you can set a provider using 
`LocalFileImageDataProvider(fileURL: url)`
works

using the ImageDownloader fails with the same `NSURLErrorDomain Code=-999` 
and `ImageDownloader.default.downloadImage(with: url...` does not provide an ability to set a provider.

To be honest, I'm unsure if this is really a feature request for the ImageDownloader class.

