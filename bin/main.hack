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
    while(!$isValidInput){
      await $out->writeAllAsync($message);
      $input = await $_in->readFixedSizeAsync(4);
      $split = Str\split($input, ' ');
      
      $x = Str\to_int($split[0]);
      if($x is null) {
        await check()
      }
      else $isValidInput = true;
    }
  }    
}

async function check() : Awaitable<void>{

}