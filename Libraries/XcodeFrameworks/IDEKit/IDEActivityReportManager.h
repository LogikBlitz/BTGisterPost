/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "NSObject.h"

#import "DVTInvalidation-Protocol.h"

@class DVTStackBacktrace, IDEActivityReport, IDEWorkspaceDocument, NSArray, NSMutableSet, NSSet;

@interface IDEActivityReportManager : NSObject <DVTInvalidation>
{
    IDEActivityReport *_lastCompletedPersistentSchemeBasedReport;
    IDEActivityReport *_lastCompletedSchemeBasedReport;
    IDEActivityReport *_lastCompletedReport;
    DVTStackBacktrace *_invalidationBacktrace;
    IDEWorkspaceDocument *_workspaceDocument;
    NSSet *_activityReporterObservingTokens;
    NSSet *_activityReporters;
    NSMutableSet *_observers;
    NSArray *_orderedActivityReports;
    NSSet *_activityReports;
    BOOL _isInvalidated;
}

@property(readonly) NSSet *activityReporters;
@property(copy) NSSet *activityReports; // @synthesize activityReports=_activityReports;
- (id)addObserver:(id)arg1;
- (void)handleUpdateFromActivityReporter:(id)arg1;
- (id)initWithWorkspaceDocument:(id)arg1;
- (void)invalidate;
@property(readonly) DVTStackBacktrace *invalidationBacktrace; // @synthesize invalidationBacktrace=_invalidationBacktrace;
@property(readonly, getter=isValid) BOOL valid;
@property IDEActivityReport *lastCompletedPersistentSchemeBasedReport; // @synthesize lastCompletedPersistentSchemeBasedReport=_lastCompletedPersistentSchemeBasedReport;
@property(readonly) IDEActivityReport *lastCompletedReport; // @synthesize lastCompletedReport=_lastCompletedReport;
@property IDEActivityReport *lastCompletedSchemeBasedReport; // @synthesize lastCompletedSchemeBasedReport=_lastCompletedSchemeBasedReport;
- (void)loadActivityReporters;
@property(copy) NSArray *orderedActivityReports; // @synthesize orderedActivityReports=_orderedActivityReports;
- (void)rebuildActivityReportCaches;
- (void)removeObserverBlock:(id)arg1;
- (void)reportDidComplete:(id)arg1;
- (void)setLastCompletedReport:(id)arg1;
- (void)startObservingReportForCompletion:(id)arg1;
- (void)stopObservingReportForCompletion:(id)arg1;
@property(readonly) IDEWorkspaceDocument *workspaceDocument; // @synthesize workspaceDocument=_workspaceDocument;

@end
