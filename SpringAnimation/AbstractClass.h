//
//  AbstractClass.h
//  SpringAnimation
//
//  Created by Matt Zanchelli on 3/11/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#ifndef SpringAnimation_AbstractClass_h
#define SpringAnimation_AbstractClass_h

/// Put this as the implementation of abstract methods that must be overriden.
/// @attribution http://stackoverflow.com/questions/1034373/creating-an-abstract-class-in-objective-c
#define MTZ_METHOD_MUST_BE_OVERRIDDEN @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass", __PRETTY_FUNCTION__] userInfo:nil];

#endif
