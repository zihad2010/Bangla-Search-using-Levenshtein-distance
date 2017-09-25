//
//  ViewController.m
//  search referance
//
//  Created by Zihad on 3/21/16.
//  Copyright (c) 2016 zihad. All rights reserved.
//

#import "ViewController.h"
#import "TableCell.h"
#import "SuggestiveTextField.h"

@interface ViewController ()
{
    
    
    NSString *str;
    NSArray *array ;
    SuggestiveTextField *ob;
    NSMutableArray *subArray;
    NSMutableArray *match;
    
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSMutableArray *array3;
    NSMutableArray *array4;
    NSMutableArray *array5;
    NSMutableArray *array6;
    NSMutableArray *array7;
    NSMutableArray *array8;
    NSMutableArray *array9;
    NSMutableArray *array10;
    NSMutableArray *array11;
    
    
    
    
    
    NSMutableArray *arraya;
    NSMutableArray *arrayb;
    NSMutableArray *arrayc;
    NSMutableArray *arrayd;
    NSMutableArray *arraye;
    NSMutableArray *arrayf;
    NSMutableArray *arrayg;
    NSMutableArray *arrayh;
    NSMutableArray *arrayi;
    NSMutableArray *arrayj;
    NSMutableArray *arrayk;
}
@property(assign) IBOutlet SuggestiveTextField *textField;
@property(nonatomic, strong) NSArray *matchedStrings;
@end

@implementation ViewController
@synthesize  dataTextField,sortString,sortDistance,result,resultTable,myView;
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    butto.layer.cornerRadius=5;
    savebutton.layer.cornerRadius=5;
    

    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"txt"];
     //NSString *filepath = [[NSBundle mainBundle] pathForResource:@"zihad" ofType:@"txt"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    
    array= [fileContents componentsSeparatedByString:@"\n"];
    [_textField setSuggestions:array];
    
    
   sortDistance=[[NSMutableArray alloc]init];
    sortString=[[NSMutableArray alloc]init];
    result=[[NSMutableArray alloc]init];
    subArray=[[NSMutableArray alloc]init];

   _matchedStrings=[[NSMutableArray alloc]init];
    
    
    
    
    array1=[[NSMutableArray alloc]init];
    array2=[[NSMutableArray alloc]init];
    array3=[[NSMutableArray alloc]init];
    array4=[[NSMutableArray alloc]init];
    array5=[[NSMutableArray alloc]init];
    array6=[[NSMutableArray alloc]init];
    array7=[[NSMutableArray alloc]init];
    array8=[[NSMutableArray alloc]init];
    array9=[[NSMutableArray alloc]init];
    array10=[[NSMutableArray alloc]init];
    array11=[[NSMutableArray alloc]init];
    
    
    arraya=[[NSMutableArray alloc]init];
    arrayb=[[NSMutableArray alloc]init];
    arrayc=[[NSMutableArray alloc]init];
    arrayd=[[NSMutableArray alloc]init];
    arraye=[[NSMutableArray alloc]init];
    arrayf=[[NSMutableArray alloc]init];
    arrayg=[[NSMutableArray alloc]init];
    arrayh=[[NSMutableArray alloc]init];
    arrayi=[[NSMutableArray alloc]init];
    arrayj=[[NSMutableArray alloc]init];
    arrayk=[[NSMutableArray alloc]init];

    
    
    
    
    for (int i = 0; i <1500; i++)
    {
        [sortString addObject:@"string"];
    }

    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)search:(id)sender
{
    [self.textField resignFirstResponder];
    [array1 removeAllObjects];
    [arraya removeAllObjects];
    [array2 removeAllObjects];
    [arrayb removeAllObjects];
    [array3 removeAllObjects];
    [arrayc removeAllObjects];
    [array4 removeAllObjects];
    [arrayd removeAllObjects];
    [array5 removeAllObjects];
    [arraye removeAllObjects];
    [array6 removeAllObjects];
    [arrayf removeAllObjects];
    [array7 removeAllObjects];
    [arrayg removeAllObjects];
    [array8 removeAllObjects];
    [arrayh removeAllObjects];
    [array9 removeAllObjects];
    [arrayi removeAllObjects];
    [array10 removeAllObjects];
    [arrayj removeAllObjects];
    [array11 removeAllObjects];
    [arrayk removeAllObjects];
    

    for (NSString *string in array)
    {
        
        int dis;
        dis=[self compareString:string withString:self.textField.text];
       
        
      if (dis<=5)
        {
            
         [array1 addObject:string];
            [arraya addObject:[NSString stringWithFormat:@"%d",dis]];
            
        }
        else if (dis<=10)
        {
            [array2 addObject:string];
            [arrayb addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=15)
        {
            [array3 addObject:string];
            [arrayc addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=20)
        {
            [array4 addObject:string];
            [arrayd addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=25)
        {
            [array5 addObject:string];
            [arraye addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=30)
        {
            [array6 addObject:string];
            [arrayf addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=35)
        {
            [array7 addObject:string];
            [arrayg addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=40)
        {
            [array8 addObject:string];
            [arrayh addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=45)
        {
            [array9 addObject:string];
            [arrayi addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else if (dis<=50)
        {
            [array10 addObject:string];
            [arrayj addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        else
        {
            [array11 addObject:string];
            [arrayk addObject:[NSString stringWithFormat:@"%d",dis]];
        }
        
    }
    NSLog(@"array1:%@",array1);
     NSLog(@"arraya:%@",arraya);
    NSLog(@"array2:%@",array2);
     NSLog(@"arrayb:%@",arrayb);
    NSLog(@"array3:%@",array3);
     NSLog(@"arrayc:%@",arrayc);
    NSLog(@"array4:%@",array4);
     NSLog(@"arrayd:%@",arrayd);
    NSLog(@"array5:%@",array5);
     NSLog(@"arraye:%@",arraye);
    NSLog(@"array6:%@",array6);
     NSLog(@"arrayf:%@",arrayf);
    NSLog(@"array7:%@",array7);
     NSLog(@"arrayg:%@",arrayg);
    NSLog(@"array8:%@",array8);
     NSLog(@"arrayh:%@",arrayh);
    
    NSLog(@"array9:%@",array9);
     NSLog(@"arrayi:%@",arrayi);
    NSLog(@"array10:%@",array10);
     NSLog(@"arrayj:%@",arrayj);
    NSLog(@"array11:%@",array11);
     NSLog(@"arrayk:%@",arrayk);
    
    [result removeAllObjects];
    
    for (int i=0; i<array1.count; i++)
    {
        [result addObject:[array1 objectAtIndex:i]];
    }
    for (int i=0; i<array2.count; i++)
    {
        [result addObject:[array2 objectAtIndex:i]];
    }
    for (int i=0; i<array3.count; i++)
    {
        [result addObject:[array3 objectAtIndex:i]];
    }
    for (int i=0; i<array4.count; i++)
    {
        [result addObject:[array4 objectAtIndex:i]];
    }
    for (int i=0; i<array5.count; i++)
    {
        [result addObject:[array5 objectAtIndex:i]];
    }
    for (int i=0; i<array6.count; i++)
    {
        [result addObject:[array6 objectAtIndex:i]];
    }
    for (int i=0; i<array7.count; i++)
    {
        [result addObject:[array7 objectAtIndex:i]];
    }
    for (int i=0; i<array8.count; i++)
    {
        [result addObject:[array8 objectAtIndex:i]];
    }
    for (int i=0; i<array9.count; i++)
    {
        [result addObject:[array9 objectAtIndex:i]];
    }
    for (int i=0; i<array10.count; i++)
    {
        [result addObject:[array10 objectAtIndex:i]];
    }
    for (int i=0; i<array11.count; i++)
    {
        [result addObject:[array11 objectAtIndex:i]];
    }
    
    [subArray removeAllObjects];
    for (int i=0; i<20; i++)
    {
        if ([[result objectAtIndex:i]isEqualToString:@""])
        {
            
        }
        else
        {
            [subArray addObject:[result objectAtIndex:i]];
        }
        
}

 [self.myView reloadData];


    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cell";
    
     TableCell *cell = [myView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        
    
    
    cell.textban.text=[subArray objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText =[subArray objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
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
        
        return (int)distance;
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
