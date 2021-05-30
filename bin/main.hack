#!/usr/bin/env hhvm
use namespace HH\Lib\{File, IO, Str, PseudoRandom};
<<__EntryPoint>>
async function main(): Awaitable<void> {
  require_once(__DIR__.'/../vendor/autoload.hack');
  \Facebook\AutoloadMap\initialize();

  await startGame();
}

async function startGame(): Awaitable<void>{
  $board = new Board();

  $_in = IO\request_input();
  $out = IO\request_output();
  $items = dict[0 => 'O', 1 => 'X']; // o is for player, 1 for computer
  $turn = 0;

  $message = "Enter the coordinates on the board seperated by single space\n";

  while (!$board->checkWin()){
    while(true){
      await $out->writeAllAsync($message);
      $input = await $_in->readFixedSizeAsync(4);
      $split = Str\split($input, ' ');
      
      $x = Str\to_int($split[0]);
      $y = Str\to_int(Str\split($split[1], '')[0]);
  
      if(!($x is null) && !($y is null)) {
        $point = new Point($x - 1, $y - 1);
        
        if(!$board->isValidPoint($point, $items[$turn])) echo $point." is not valid, not on board or no neigbour placed\n";
        else if($board->isSet($point)) await $out->writeAllAsync($point." is already set");
        else await play($point, $board);

        if($turn) $turn--; // when turn is 1
        else $turn++; // when 0
      }
    }
  }    
}

async function play(Point $point, Board $board) : Awaitable<void>{
  $board->set($point, 'O');
  await computerPlay($board);
  echo $board->print();
}

async function computerPlay(Board $board): Awaitable<void>{
  $point = await getRandomValidPoint($board);
  $board->set($point, 'X');
}


async function getRandomValidPoint(Board $board): Awaitable<Point>{
  $point = await getRandomPoint();
  while(!$board->isSet($point) && !$board->isValidPoint($point, 'X')){
    $point = await getRandomPoint();
  }
  // echo $point;
  return $point;
}

async function getRandomPoint(): Awaitable<Point>{
  $randomX = PseudoRandom\int(0,2);
  $randomY = PseudoRandom\int(0,2);
  return new Point($randomX, $randomY);
} 
