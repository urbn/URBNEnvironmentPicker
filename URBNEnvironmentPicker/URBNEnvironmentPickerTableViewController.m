
#import "URBNEnvironmentPickerTableViewController.h"
#import "URBNEnvironmentController.h"
#import "URBNEnvironment.h"
#import <BlocksKit/BlocksKit.h>

@interface URBNEnvironmentPickerTableViewController ()

@property (nonatomic, strong) URBNEnvironment *selectedEnvironment;

@end

@implementation URBNEnvironmentPickerTableViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.selectedEnvironment = [self currentEnvironment];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                             style:UIBarButtonItemStyleBordered
                                                            target:self
                                                            action:@selector(cancel:)];

    self.navigationItem.leftBarButtonItem = item;

    item = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                            style:UIBarButtonItemStyleBordered
                                           target:self
                                           action:@selector(save:)];

    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSIndexPath *indexPath = [self indexPathOfEnvironment:[self currentEnvironment]];
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Utility Methods

- (NSArray *)environments
{
    return [[URBNEnvironmentController sharedInstance] availableEnvironments];
}

- (URBNEnvironment *)currentEnvironment
{
    return [[URBNEnvironmentController sharedInstance] currentEnvironment];
}

- (NSIndexPath *)indexPathOfEnvironment:(URBNEnvironment *)environment
{
    NSUInteger index = [[self environments] indexOfObjectPassingTest:^BOOL(URBNEnvironment *obj, NSUInteger idx, BOOL *stop) {
        
        if([environment isEqual:obj]){
            
            *stop = YES;
            return YES;
        }
        
        return NO;
    }];

    if (index == NSNotFound)
        return nil;

    return [NSIndexPath indexPathForRow:index
                              inSection:0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self environments] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }

    URBNEnvironment *environment = [self environments][indexPath.row];
    cell.textLabel.text = environment.displayName;
    cell.detailTextLabel.text = environment.displayDescription;

    if ([environment isEqual:[self selectedEnvironment]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.tableView selectRowAtIndexPath:indexPath
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedEnvironment = [self environments][indexPath.row];
    [self.tableView reloadData];
}

#pragma mark - Actions

- (IBAction)save:(id)sender
{

    UIAlertView *areYouSureAlert = [UIAlertView bk_alertViewWithTitle:@"Switching Environments"
                                                              message:@"Tap \"Switch\" to change the current environment "];

    [areYouSureAlert bk_addButtonWithTitle:@"Switch"
                                   handler:^{
                                       
                                       NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
                                       URBNEnvironment* newEnvironment = [self environments][selectedIndexPath.row];
                                       
                                       if([newEnvironment isEqual:[self currentEnvironment]]){
                                           
                                           [self dismissViewControllerAnimated:YES completion: ^{
                                               
                                               UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Environment Unchanged"
                                                                                               message:@"The new environment is the same as the old environment"];
                                               
                                               [alert bk_setCancelBlock:^{    
                                                   //nonop
                                               }];
                                               
                                               [alert show];
                                               
                                           }];
                                           
                                       }
                                       
                                       [[URBNEnvironmentController sharedInstance] changeToEnvironment:newEnvironment];
                                   }];

    [areYouSureAlert bk_setCancelButtonWithTitle:@"Never Mind"
                                         handler:^{
                                                   //nonop
                                                 }];

    [areYouSureAlert show];
}

- (IBAction)cancel:(id)sender
{

    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}

@end
