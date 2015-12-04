//
//  OBEncodeMacro.h
//  OBFoundationLib
//
//  Created by Oborn.Jung on 8/26/14.
//  Copyright (c) 2014 ObornJung. All rights reserved.
//

#ifndef OBFoundationLib_OBEncodeMacro_h
#define OBFoundationLib_OBEncodeMacro_h

#define OB_STRINGIFY(string)                @#string
#define OB_EncodeObject(coder, object)      [coder encodeObject:object forKey:OBSTRINGIFY(object)]
#define OB_EncodeBool(coder, value)         [coder encodeBool:[NSNumber numberWithBool:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeInt(coder, value)          [coder encodeInt:[NSNumber numberWithInt:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeInt32(coder, value)        [coder encodeInt32:[NSNumber numberWithLong:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeInt64(coder, value)        [coder encodeInt64:[NSNumber numberWithLongLong:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeFloat(coder, value)        [coder encodeFloat:[NSNumber numberWithFloat:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeDouble(coder, value)       [coder encodeDouble:[NSNumber numberWithFloat:value] forKey:OBSTRINGIFY(value)]
#define OB_EncodeBytes(coder, bytesp, lenv) [coder encodeBytes:bytesp length:bytesp forKey:OBSTRINGIFY(bytesp)]

#endif /* OBFoundationLib_OBEncodeMacro_h */
