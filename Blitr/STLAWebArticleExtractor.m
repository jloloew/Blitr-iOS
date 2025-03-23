//
//  STLAWebArticleExtractor.m
//  Blitr
//
//  Created by Justin Loew on 3/22/25.
//  Copyright © 2025 Justin Loew. All rights reserved.
//

@import Foundation;

#import <AFNetworking.h>

#import "STLAConstants.h"
#import "STLAWebArticleExtractor.h"


@implementation STLAWebArticleExtractor

- (void)extractArticleAtURL:(NSString *)articleURL
					success:(void (^)(NSString *blockText))successCompletion
					failure:(void (^)(NSString *errorMessage))failureCompletion
{
	AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
	NSDictionary *requestParameters = @{ @"url": articleURL,
										 @"apikey": API_KEY,
										 @"outputMode": @"json" };
	[manager GET:API_URL parameters:requestParameters progress: nil
		 success:^(NSURLSessionTask *task, id responseObject) {
		// Turn the responseObject into useful text.
		if (![responseObject isKindOfClass:[NSDictionary class]]) {  // Safety check.
			NSLog(@"Error: responseObject is not a dictionary.");
			failureCompletion(NSLocalizedString(@"Blitr's servers aren't able to turn this page into text right now. Please try again later.", nil));
			return;
		}
		
		NSDictionary *responseDict = (NSDictionary *)responseObject;
		NSString *blockText = responseDict[@"text"];
		if (!blockText) {  // Safety check.
			NSLog(@"Error: couldn't get text from JSON response.");
			failureCompletion(NSLocalizedString(@"Unable to get text from website. Blitr doesn't work on PDFs, documents, or images.", nil));
			return;
		}
		
		successCompletion(blockText);
	}
		 failure:^(NSURLSessionTask *task, NSError *error) {
		NSLog(@"Failed to get text from current website: %@", error);
		failureCompletion(NSLocalizedString(@"Unable to get text from website. Blitr doesn't work on PDFs, documents, or images.", nil));
	}];
}

@end
