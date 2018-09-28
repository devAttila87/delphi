unit CommonTypes;

interface

type
  TLocation = (
    ltGoldmine,
    ltBank,
    ltSaloon,
    ltHome
  );

  TMinerAction = (
    maWalkingToGoldmine,
    maPickingNugget,
    maLeavingGoldmine,

    maGoingToBank,
    maDepositingGold,
    maRichEnough,
    maLeavingTheBank,

    maWalkingToSaloon,
    maDrinkLiquor,
    maLeavingSaloon,

    maGoingHome,
    maSleepingHome,
    maWakingUpHome
  );

const
  TMinerActionString: array[TMinerAction] of string = (
    'Walkin'' to the gold mine',
    'Pickin'' up a nugget',
    'Leavin'' the gold mine with ma pockets full o'' sweet gold',

    'Goin'' to the bank. Yes siree',
    'Depositin'' gold. Total savings now: %d',
    'Woohoo! Rich enough for now! Back home to mah li''l lady',
    'Leavin'' the bank',

    'Boy, ah sure is thirsty! Walking to the saloon',
    'That''s mighty fine sippin liquor',
    'Leavin'' the saloon, feelin'' good',

    'Walkin'' home',
    'zzzZZZzzz...',
    'What a God-darn fanatistic nap! Time to find more gold'
  );

type
  TMinerName = (
    mnBob,
    mnJerk,
    mnJohn,
    mnKarl,
    mnJim,
    mnMike,
    mnTom,
    mnCharlie
  );

const
  TMinerNameString: array[TMinerName] of string = (
    'Bob',
    'Jerk',
    'John',
    'Karl',
    'Jim',
    'Mike',
    'Tom',
    'Charlie'
  );

implementation

end.
