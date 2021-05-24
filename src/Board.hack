use namespace HH\Lib\{C};
class Board{
    
    private int $n = 3;
    private vec<vec<string>> $board;
    private int $o_count;
    private int $x_count;

    public function __construct(){
        $this->board = [
                        [null, null, null], 
                        [null, null, null], 
                        [null, null, null]
                    ];
        $this->o_count = 0;
        $this->x_count = 0;
                

    }

    public function __toString(): string {
        // todo
        $boardStr = "";
        foreach($this->board as $row){
            foreach($row as $entry){
                $boardStr." ".$entry;
            }
        }
        return $boardStr;
    }


    public function set(Point $p, string $symbol) : void{
        $x = $p->getX();
        $y = $p->getY();
        $this->board[x][y] = $symbol;
        $this->updateSymbolCount();
    }


    private function updateSymbolCount(string $symbol){
        if($symbol === 'O') $this->o_count++;
        else $this->x_count++;
    }

    public function get(Point $p): string{
        $x = $p->getX();
        $y = $p->getY();
        return $this->board[x][y];
    }

    public function isSet(Point $p): bool{
        $x = $p->getX();
        $y = $p->getY();

        return $this->board[x][y] !== null;
    }

    public function checkWin(): bool{


    }

    public function isValidPoint(Point $p): bool{
        return $p->getX() < $this->n && $p->getY() < $this->n;
    }

    public function isValidPoint(Point $p, string $symbol) : bool {
        $count = 0;
        if($symbol === 'O') $count = $this->o_count;
        else $count = $this->x_count;

        if ($count === 0) return $this->isValidPoint($p);
        else{
            $x = vec[1,-1, 0,  0, 1, -1, 1, -1]
            $y = vec[0, 0, 1, -1, 1, -1, -1, 1]

            // check if adjacent piece exists
            $size = C\count($x);
            for($i = 0; $i < $size; $i++){
                $j = $p->getX();
                $k = $p->getY();
                $x_adj = $x[$i] + $j; 
                $y_adj = $y[$i] + $k; 

                if($this->board[$x_adj][$y_adj] === $symbol) return true;
            }

            return false;
        }        

    }
}