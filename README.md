# RandomManager
Random Algorithm Selector

# How to use

```delphi
uses
  PK.Math.Random.RandomManager;

procedure Sample;
begin
  TRandomManager.Current.SetAlgo('XorShift');

  Randomize;
  Writeln(Random(10));
end;
```

# Available Algorithms

|Algorithms|Text|Unit|
|---|---|---|
|Linear congruential generators|LCG|PK.Math.Random.LCG.pas|
|CNG Random|CNG|PK.Math.Random.CNG.pas|
|XorShift|XorShift|PK.Math.Random.XorShift.pas|
|MersenneTwister|MT|PK.Math.Random.MersenneTwister.pas|

# History
2024/12/12  FirstRelease

# LICENSE
Copyright 2024 piksware  
https://piksware.com/
