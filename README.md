#BlockKit

_By Ulrik Flænø Damm_

This kit includes some useful methods using blocks. It currently has downloading and timing methods.

##BKDownload

This class has some class methods for downloading things.

###Downloading data

Downloading data is done using the `+ (void)dataDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadDataCompletionBlock)completion` method.

####Example

	[BKDownload dataDownloadWithRequest:[@"http://example.com" URLRequest] completion:^(NSData *result, NSError *error) {
		if (error) {
			// handle error
			return;
		}
	
		// use result
	}];


###Downloading images

Downloading data is done using the `+ (void)imageDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadImageCompletionBlock)completion` method.

####Example

	[BKDownload imageDownloadWithRequest:[@"http://example.com/image.png" URLRequest] completion:^(UIImage *result, NSError *error) {
		if (error) {
			// handle error
			return;
		}

		// use result
	}];

###Downloading strings

Downloading data is done using the `+ (void)stringDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadStringCompletionBlock)completion` method.

####Example

	[BKDownload stringDownloadWithRequest:[@"http://example.com/tekst.txt" URLRequest] completion:^(NSString *result, NSError *error) {
		if (error) {
			// handle error
			return;
		}

		// use result
	}];

##BKTimer

This class has some class methods for asynchronously timing things.

###Non-repeating timer

A non-repeating timer is made using the `+ (void)timerWithDelay:(NSTimeInterval)delay completion:(BKTimerCompletionBlock)completion` method.

####Example

	[BKTimer timerWithDelay:2 completion:^{
		// will be called after 2 seconds
	}]


###Repeating timer

A repeating timer is made using the `+ (void)repeatingTimerWithDelay:(NSTimeInterval)delay completion:(BKTimerRepeatingCompletionBlock)completion` method.

####Example

	[BKTimer repeatingTimerWithDelay:2 completion:^BOOL {
		// will be called after 2 seconds
		// will be repeated, unless this block returns NO
	}]

##Notes

- The BKDownload class includes a category on NSString, so that you can call the `- (NSURLRequest*)URLRequest` to get a NSURLRequest instance from a URL string.
- All blocks are called on the main thread.
