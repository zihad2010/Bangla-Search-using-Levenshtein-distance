//
//  SuggestiveTextField.m
//  SuggestiveTextField
//
//  Created by Wojciech Mandrysz on 19/09/2011.
//  Copyright 2011 http://tetek.wordpress.com . All rights reserved.
//

#import "SuggestiveTextField.h"
#import "bojectClass.h"
#define DEFAULT_ROW_HEIGHT 35.0

@interface SuggestiveDelegate : NSObject <UITextFieldDelegate>
{
    bojectClass *ob;
}

@property(weak) SuggestiveTextField *textField;
@end

@implementation SuggestiveDelegate

//////////////////////////////////////////////////
#pragma mark - Handling TextField Delegate
//////////////////////////////////////////////////


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
	
    NSMutableString *text = [NSMutableString stringWithString:textField.text];
	[text replaceCharactersInRange:range withString:string];
	
	[self.textField matchStrings:text];
	[self.textField showSuggestionTableView];
	
	return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
	[self.textField dismissSuggestionTableView];
	return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return YES;
}

@end



@interface SuggestiveTextField () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *stringsArray;
@property(nonatomic, strong) NSArray *matchedStrings;
@property(nonatomic, strong) UITableViewController *controller;
@property(nonatomic, strong) SuggestiveDelegate *midDelegate;

@property CGSize tableViewMaxSize;

@property(nonatomic, strong) UIPopoverController *popOver; // iPad
@end

@implementation SuggestiveTextField
@synthesize sortDistance,sortString,result,resultTable;

//////////////////////////////////////////////////
#pragma mark - Setup
//////////////////////////////////////////////////

- (id)initWithCoder:(NSCoder *)aDecoder
{
    //NSLog(@"call me");
    sortDistance=[[NSMutableArray alloc]init];
    sortString=[[NSMutableArray alloc]init];
    result=[[NSMutableArray alloc]init];
    resultTable=[[NSMutableArray alloc]init];

    for (int i = 0; i < 2000; i++) {
        [sortString addObject:@"string"];
    }

  if ((self = [super initWithCoder:aDecoder])) {
    [self setup];
  }
  return self;
}
- (id)initWithFrame:(CGRect)frame {

  if ((self = [super initWithFrame:frame])) {
    [self setup];
  }
  return self;
}
- (id)init {

  if ((self = [super init])) {
    [self setup];
  }
  return self;
}

- (void)setup {
    
    

    self.midDelegate = [SuggestiveDelegate new];
    self.midDelegate.textField = self;
	self.delegate = self.midDelegate;

    self.matchedStrings = [NSArray array];
    self.controller = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.controller.tableView.delegate = self;
    self.controller.tableView.dataSource = self;
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.tableViewMaxSize = CGSizeMake(self.frame.size.width, 300);
    
    
    if (self.isiPad) {
        self.popOver = [[UIPopoverController alloc] initWithContentViewController:self.controller];
        self.popOver.popoverContentSize = self.tableViewMaxSize;
    }

    // Default values
    self.shouldHideOnSelection = YES;
    
	// Table view configs
	self.controller.tableView.backgroundColor = [UIColor whiteColor];
	self.controller.tableView.layer.cornerRadius = 5;
	self.controller.tableView.layer.borderWidth = 0.2;
	self.controller.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.controller.tableView.bounces = YES;
	self.controller.tableView.alwaysBounceVertical = YES;
	self.controller.tableView.showsVerticalScrollIndicator = YES;
	self.controller.tableView.showsHorizontalScrollIndicator = NO;
	self.controller.tableView.rowHeight = DEFAULT_ROW_HEIGHT;
	self.controller.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // Hide the unnecessary separator lines
	
}

- (void) dismissSuggestionTableView{
    if (self.isiPad) {
        [_popOver dismissPopoverAnimated:YES];
    }
    else{
        [self.controller.tableView removeFromSuperview];
    }
}


//////////////////////////////////////////////////
#pragma mark - Modifiers
//////////////////////////////////////////////////

- (void)setSuggestions:(NSArray *)suggestionStrings {
    self.stringsArray = suggestionStrings;
}
- (void)setPopoverSize:(CGSize)size {
    self.tableViewMaxSize = size;
    self.popOver.popoverContentSize = size;
}

//////////////////////////////////////////////////
#pragma mark - Matching strings and Popover
//////////////////////////////////////////////////

- (CGFloat)tableHeight{
	return [self.matchedStrings count] * DEFAULT_ROW_HEIGHT > self.tableViewMaxSize.height ? self.tableViewMaxSize.height : [self.matchedStrings count] * DEFAULT_ROW_HEIGHT;
}

- (void)updateTableViewFrameHeight
{
	if (!self.isiPad) {
		CGRect currentFrame = self.controller.tableView.frame;
		currentFrame.size.height = [self tableHeight];
		self.controller.tableView.frame = currentFrame;
	}
	else{
		[self setPopoverSize:CGSizeMake(self.tableViewMaxSize.width, [self tableHeight])];
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)matchStrings:(NSString *)letters {
  if (_stringsArray.count > 0)
  {

    self.matchedStrings = [_stringsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self contains[cd] %@", letters]];
    //[_controller.tableView reloadData];

    [self updateTableViewFrameHeight];
  }
    
    
   
    [sortDistance removeAllObjects];
    //[sortString removeAllObjects];
    for (NSString *string in _matchedStrings)
    {
       // NSLog(@"%@", string);
       // NSLog(@"%@", letters);
        
        int dis;
        dis=[self compareString:string withString:letters];
        [sortDistance addObject:[NSString stringWithFormat:@"%d",dis]];
       // [sortDistance addObject:(NSInteger)dis];
       // NSLog(@"jhagdsgdcsdvjfsdvfsdfdjfb:%d",dis);
        if (dis<=2000)
        {
            
            //[sortString insertObject:string atIndex:(NSInteger)dis];
            [sortString replaceObjectAtIndex:dis  withObject:string];
        

        }
        
    }
   
    
    
    ///////////////////////////////////unique value///////////////////
    
    NSMutableArray *unique = [NSMutableArray array];
    for (id obj in sortDistance) {
        if (![unique containsObject:obj]) {
            [unique addObject:obj];
        }
    }
   // NSLog(@"uniqe value : %@",unique);
     ///////////////////////////////////sort  value///////////////////
    
    int temp;
    for (int i=0; i<unique.count; i++)
    {
        for (int j=i+1; j<unique.count; j++)
        {
            if ([[unique objectAtIndex:i] intValue]>[[unique objectAtIndex:j] intValue])
            {
                temp=[[unique objectAtIndex:i] intValue];
                [unique replaceObjectAtIndex:i  withObject:[unique objectAtIndex:j]];
                [unique replaceObjectAtIndex:j  withObject:[NSString stringWithFormat:@"%d",temp]];
                
                
                
            }
            
        }
        
        
    }
   // NSLog(@"%@",unique);
     //NSLog(@"%@",sortString);

    
    
    // NSLog(@"sortArray : %@",sortString);
//    for (int i = 0; i < 100; i++) {
//        [sortString addObject:@"string"];
//    }
    [result removeAllObjects];
    for (int i=0; i<unique.count; i++)
    {
        int tem;
        tem=[[unique objectAtIndex:i] intValue];
        [result addObject:[sortString objectAtIndex:tem]];
        
        
    }
//    for (int i=0; i<result.count; i++)
//    {
//        
//        [resultTable addObject:[result objectAtIndex:i]];
//        
//        
//    }
    // NSLog(@"result:%@",result);
     [_controller.tableView reloadData];
   // [result removeAllObjects];

    
   
}

- (void)showSuggestionTableView {
	if (_matchedStrings.count == 0){
		[self dismissSuggestionTableView];
	}
    
	else if (!_popOver.isPopoverVisible && self.isiPad){
			[_popOver presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
	}
	else if (!self.isTableViewVisible && !self.isiPad)
	{
		if (!self.referenceView) { // if the reference view is not set, then it has the default window.
			self.referenceView = self.window;
		}
		CGPoint origin = [self.referenceView convertPoint:self.frame.origin fromView:self.superview];
		CGRect rect;
		rect.origin = CGPointMake(origin.x, origin.y + self.frame.size.height);
		rect.size = CGSizeMake(self.frame.size.width, [self tableHeight]);
		
		self.controller.tableView.frame = rect;
		[self.referenceView addSubview: self.controller.tableView];
		

	}
}

- (BOOL)isTableViewVisible{
    return self.controller.tableView.superview != nil;
}

-(BOOL)isiPad{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

//////////////////////////////////////////////////
#pragma mark - TableView Delegate & DataSource
//////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

  
    
    cell.textLabel.text=[result objectAtIndex:indexPath.row];
    //[result removeAllObjects];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [self setText: [result objectAtIndex:indexPath.row]];
    
    if (_shouldHideOnSelection) {
        [self dismissSuggestionTableView];
		[self resignFirstResponder];
		
    }
}
//////////////////algorithm////////////////////////////////////
-(int)compareString:(NSString *)originalString withString:(NSString *)comparisonString
{
    // Normalize strings
    [originalString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [comparisonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    originalString = [originalString lowercaseString];
    comparisonString = [comparisonString lowercaseString];
    
    // Step 1 (Steps follow description at http://www.merriampark.com/ld.htm)
    NSInteger k, i, j, cost, * d, distance;
    
    NSInteger n = [originalString length];
    NSInteger m = [comparisonString length];
    
    if( n++ != 0 && m++ != 0 ) {
        
        d = malloc( sizeof(NSInteger) * m * n );
        
        // Step 2
        for( k = 0; k < n; k++)
            d[k] = k;
        
        for( k = 0; k < m; k++)
            d[ k * n ] = k;
        
        // Step 3 and 4
        for( i = 1; i < n; i++ )
            for( j = 1; j < m; j++ ) {
                
                // Step 5
                if( [originalString characterAtIndex: i-1] ==
                   [comparisonString characterAtIndex: j-1] )
                    cost = 0;
                else
                    cost = 1;
                
                // Step 6
                d[ j * n + i ] = [self smallestOf: d [ (j - 1) * n + i ] + 1
                                            andOf: d[ j * n + i - 1 ] +  1
                                            andOf: d[ (j - 1) * n + i - 1 ] + cost ];
                
                // This conditional adds Damerau transposition to Levenshtein distance
                if( i>1 && j>1 && [originalString characterAtIndex: i-1] ==
                   [comparisonString characterAtIndex: j-2] &&
                   [originalString characterAtIndex: i-2] ==
                   [comparisonString characterAtIndex: j-1] )
                {
                    d[ j * n + i] = [self smallestOf: d[ j * n + i ]
                                               andOf: d[ (j - 2) * n + i - 2 ] + cost ];
                }
            }
        
        distance = d[ n * m - 1 ];
        
        free( d );
        
        return distance;
    }
    return 0.0;
}

// Return the minimum of a, b and c - used by compareString:withString:
-(NSInteger)smallestOf:(NSInteger)a andOf:(NSInteger)b andOf:(NSInteger)c
{
    NSInteger min = a;
    if ( b < min )
        min = b;
    
    if( c < min )
        min = c;
    
    return min;
}

-(NSInteger)smallestOf:(NSInteger)a andOf:(NSInteger)b
{
    NSInteger min=a;
    if (b < min)
        min=b;
    
    return min;
}


@end
