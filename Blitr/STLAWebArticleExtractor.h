//
//  STLAWebArticleExtractor.h
//  Blitr
//
//  Created by Justin Loew on 3/22/25.
//  Copyright © 2025 Justin Loew. All rights reserved.
//

#ifndef STLAWebArticleExtractor_h
#define STLAWebArticleExtractor_h

@import Foundation;


/// Strips a webpage down to just the text of the article shown on the page.
@interface STLAWebArticleExtractor : NSObject

/// Attempt to strip a webpage down to just the text of the page's article.
/// - Parameters:
///   - articleURL: URL string of an article to strip.
///   - successCompletion: Callback for when extraction succeeds. Takes a single argument, an `NSString` containing the plain text of the article, and returns `void`.
///   - failureCompletion: Callback for when extraction succeeds. Takes a single argument, an `NSString` error message, and returns `void`.
- (void)extractArticleAtURL:(NSString *)articleURL
					success:(void (^)(NSString *blockText))successCompletion
					failure:(void (^)(NSString *errorMessage))failureCompletion;

@end

#endif /* STLAWebArticleExtractor_h */
