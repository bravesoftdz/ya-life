unit TestPattern;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Classes, Types, Engine.UPattern, Engine.UGrid, Engine.URules,
  Engine.UCommon, UStructs;

type
  // Test methods for class TPattern

  TestTPattern = class(TTestCase)
  strict private
    fPattern: TPattern;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestNameProp;
    procedure TestAuthorProp;
    procedure TestDescriptionProp;
    procedure TestRuleProp;
    procedure TestGridProp;
  end;

implementation

procedure TestTPattern.SetUp;
begin
  fPattern := TPattern.Create;
end;

procedure TestTPattern.TearDown;
begin
  fPattern.Free;
  fPattern := nil;
end;

procedure TestTPattern.TestAuthorProp;
begin
  fPattern.Author := 'An author';
  CheckEquals('An author', fPattern.Author, 'Test 1');
  fPattern.Author := 'An'#13'author'#10#10'with'#13#10'EOLs'#13#10;
  CheckEquals('An author  with EOLs', fPattern.Author, 'Test 2');
  fPattern.Author := '  An author  ';
  CheckEquals('An author', fPattern.Author, 'Test 3');
end;

procedure TestTPattern.TestDescriptionProp;
var
  D: TStringList;
begin
  D := TStringList.Create;
  try
    D.Add('This is');
    D.Add('a description');
    fPattern.Description := D;
    CheckEquals(D.Text, fPattern.Description.Text);
  finally
    D.Free;
  end;
end;

procedure TestTPattern.TestGridProp;
var
  G: TGrid;
begin
  CheckEquals(0, fPattern.Grid.Size.CX, 'Test 1a');
  CheckEquals(0, fPattern.Grid.Size.CY, 'Test 1b');
  fPattern.Grid.Size := TSizeEx.Create(15, 12);
  CheckEquals(15, fPattern.Grid.Size.CX, 'Test 2a');
  CheckEquals(12, fPattern.Grid.Size.CY, 'Test 2b');
  G := TGrid.Create;
  try
    G.Size := TSizeEx.Create(24, 23);
    G[9,9] := csOn;
    fPattern.Grid := G;
    CheckTrue(G.IsEqual(fPattern.Grid), 'Test 3a');
  finally
    G.Free;
  end;
  CheckTrue(fPattern.Grid[9,9] = csOn, 'Test 3b');
end;

procedure TestTPattern.TestNameProp;
begin
  fPattern.Name := 'A name';
  CheckEquals('A name', fPattern.Name, 'Test 1');
  fPattern.Name := 'A'#13'name'#10#10'with'#13#10'EOLs'#13#10;
  CheckEquals('A name  with EOLs', fPattern.Name, 'Test 2');
  fPattern.Name := '  A name  ';
  CheckEquals('A name', fPattern.Name, 'Test 3');
end;

procedure TestTPattern.TestRuleProp;
begin
  CheckTrue(fPattern.Rule.IsNull, 'Test 1');
  fPattern.Rule := TRule.Create([2,3], [2]);
  CheckTrue([2,3] = fPattern.Rule.BirthCriteria, 'Test 2 B');
  CheckTrue([2] = fPattern.Rule.SurvivalCriteria, 'Test 2 S');
  fPattern.Rule := TRule.CreateNull;
  CheckTrue(fPattern.Rule.IsNull, 'Test 3');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTPattern.Suite);
end.

