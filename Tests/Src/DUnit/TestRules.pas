unit TestRules;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Engine.UCommon, Engine.URules;

type
  // Test methods for class TRule

  TestTRule = class(TTestCase)
  strict private
    R1, R2, R3, R4, R5, R6: TRule;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSetConstructor;
    procedure TestRuleStringConstructor;
    procedure TestCreateNul;
    procedure TestCloneConstructor;
    procedure TestApply;
    procedure TestToString;
    procedure TestToBSString;
    procedure TestIsEqual;
    procedure TestIsNull;
  end;

implementation

procedure TestTRule.SetUp;
begin
  R1 := TRule.Create([3, 6, 7, 8], [3, 4, 6, 7, 8]);
  R2 := TRule.Create([2], []);
  R3 := TRule.Create([], [6, 4, 2]);
  R4 := TRule.CreateNull;
  R5 := TRule.Create([3], [2, 3]);
  R6 := TRule.Create([3], [2, 3]);
end;

procedure TestTRule.TearDown;
begin
end;

procedure TestTRule.TestApply;
begin
  Check(R5.Apply(csOn, 4) = csOff, 'Test 5.1');
  Check(R5.Apply(csOn, 2) = csOn, 'Test 5.2');
  Check(R5.Apply(csOff, 4) = csOff, 'Test 5.3');
  Check(R5.Apply(csOff, 3) = csOn, 'Test 5.4');
  Check(R1.Apply(csOn, 5) = csOff, 'Test 1.1');
  Check(R1.Apply(csOn, 4) = csOn, 'Test 1.2');
  Check(R1.Apply(csOff, 1) = csOff, 'Test 1.3');
  Check(R1.Apply(csOff, 6) = csOn, 'Test 1.4');
end;

procedure TestTRule.TestCloneConstructor;
var
  R1, R2: TRule;
begin
  R2 := TRule.CreateNull;
  R1 := TRule.Create([3,4,5], [6,7,8]);
  R2 := TRule.Create(R1);
  Check(R2.BirthCriteria = R1.BirthCriteria, 'Test a');
  Check(R2.SurvivalCriteria = R2.SurvivalCriteria, 'Test b');
end;

procedure TestTRule.TestCreateNul;
var
  R1, R2: TRule;
begin
  R2 := TRule.CreateNull;
  R1 := TRule.Create([3,4,5], [6,7,8]);
  R2 := TRule.Create(R1);
  Check(R2.BirthCriteria = R1.BirthCriteria, 'Test a');
  Check(R2.SurvivalCriteria = R2.SurvivalCriteria, 'Test b');
end;

procedure TestTRule.TestIsEqual;
begin
  CheckTrue(R5.IsEqual(R6), 'Test 1');
  CheckTrue(R6.IsEqual(R5), 'Test 2');
  CheckFalse(R5.IsEqual(R1), 'Test 3');
  CheckFalse(R5.IsEqual(R4), 'Test 4');
end;

procedure TestTRule.TestIsNull;
var
  R: TRule;
begin
  R := TRule.Create([3], [2, 3]);
  CheckFalse(R.IsNull, 'Test 1');
  R := TRule.CreateNull;
  CheckTrue(R.IsNull, 'Test 2');
end;

procedure TestTRule.TestRuleStringConstructor;
var
  R: TRule;
begin
  R := TRule.Create('23/3');
  Check(R.BirthCriteria = [3], 'Test 1a');
  Check(R.SurvivalCriteria = [2,3], 'Test 1b');

  R := TRule.Create('B3/S23');
  Check(R.BirthCriteria = [3], 'Test 2a');
  Check(R.SurvivalCriteria = [2,3], 'Test 2b');

  R := TRule.Create('');
  Check(R.BirthCriteria = [], 'Test 3a');
  Check(R.SurvivalCriteria = [], 'Test 3b');

  R := TRule.Create('546/');
  Check(R.BirthCriteria = [], 'Test 4a');
  Check(R.SurvivalCriteria = [4,5,6], 'Test 4b');

  R := TRule.Create('546');
  Check(R.BirthCriteria = [], 'Test 5a');
  Check(R.SurvivalCriteria = [4,5,6], 'Test 5b');

  R := TRule.Create('/546');
  Check(R.BirthCriteria = [4,5,6], 'Test 6a');
  Check(R.SurvivalCriteria = [], 'Test 6b');

  R := TRule.Create('B0');
  Check(R.BirthCriteria = [0], 'Test 7a');
  Check(R.SurvivalCriteria = [], 'Test 7b');

  R := TRule.Create('/');
  Check(R.BirthCriteria = [], 'Test 8a');
  Check(R.SurvivalCriteria = [], 'Test 8b');

  R := TRule.Create('B4/');
  Check(R.BirthCriteria = [4], 'Test 9a');
  Check(R.SurvivalCriteria = [], 'Test 9b');

  R := TRule.Create('B/S12');
  Check(R.BirthCriteria = [], 'Test 10a');
  Check(R.SurvivalCriteria = [1, 2], 'Test 10b');

  R := TRule.Create('B42/S');
  Check(R.BirthCriteria = [2, 4], 'Test 11a');
  Check(R.SurvivalCriteria = [], 'Test 11b');

  try
    TRule.Create('B3S4');
    Fail('Test E1: Exception expected');
  except
  end;
  try
    TRule.Create('S4');
    Fail('Test E2: Exception expected');
  except
  end;
  try
    TRule.Create('498');
    Fail('Test E3: Exception expected');
  except
  end;
  try
    TRule.Create('B3/7');
    Fail('Test E4: Exception expected');
  except
  end;
end;

procedure TestTRule.TestSetConstructor;
var
  R: TRule;
begin
  R := TRule.Create([3], [2,3]);
  Check(R.BirthCriteria = [3], 'Test 1a');
  Check(R.SurvivalCriteria = [2,3], 'Test 1b');
end;

procedure TestTRule.TestToString;
begin
  CheckEquals('34678/3678', R1.ToString, 'Test 1');
  CheckEquals('/2', R2.ToString, 'Test 2');
  CheckEquals('246/', R3.ToString, 'Test 3');
  CheckEquals('/', R4.ToString, 'Test 4');
  CheckEquals('23/3', R5.ToString, 'Test 5');
end;

procedure TestTRule.TestToBSString;
begin
  CheckEquals('B3678/S34678', R1.ToBSString, 'Test 1');
  CheckEquals('B2/S', R2.ToBSString, 'Test 2');
  CheckEquals('B/S246', R3.ToBSString, 'Test 3');
  CheckEquals('B/S', R4.ToBSString, 'Test 4');
  CheckEquals('B3/S23', R5.ToBSString, 'Test 5');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRule.Suite);
end.

