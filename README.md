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

|Algorithms|Text|
|---|---|
|Linear congruential generators|LCG|
|CNG Random|CNG|
|XorShift|XorShift
|MersenneTwister|MT|

# History
2024/12/12  FirstRelease

# LICENSE
Copyright 2024 piksware  
https://piksware.com/
