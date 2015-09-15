//
// ODSFetchedResultsSection.h 
// Playmaker
//
// Created by dmitriy on 1/28/14
// Copyright (c) 2014 Yalantis. All rights reserved. 
//
#import "ODSArraySection.h"

@protocol NSFetchedResultsSectionInfo;

@interface ODSFetchedResultsSection : NSObject <ODSSection>

- (instancetype)initWithSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo;

@end