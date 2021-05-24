#!/usr/bin/env hhvm
use namespace HH\Lib\{File, IO, Str};
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
  $message = "Enter the coordinates on the board seperated by single space\n";

  while (!$board->checkWin()){
    $isValidInput = false;
    while(true){
      await $out->writeAllAsync($message);
      $input = await $_in->readFixedSizeAsync(4);
      $split = Str\split($input, ' ');
      
      $x = Str\to_int($split[0]);
      $y = Str\to_int($split[1]);

      if(!($x is null) && !($y is null)) {
        $point = new Point($x, $y);
        
        if($board->isSet($point)) {
          await $out->writeAllAsync($point." is already set");
        }
        else{
          play($point, $board);
        }

      }
    }
  }    
}

async function play(Point $point, Board $board) : Awaitable<void>{
  $board->set($point, 'O');
  
  await computerPlay();
}

async function computerPlay(): Awaitable<void>{

}