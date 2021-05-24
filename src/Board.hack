class Board{
    
    private int $n = 3;
    private vec<vec<string>> $board;

    public function __construct(){
        $this->board = [
                        [null, null, null], 
                        [null, null, null], 
                        [null, null, null]
                    ];
                

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

    public function set(Point $p, String $symbol) : void{
        $x = $p->getX();
        $y = $p->getY();
        $this->board[x][y] = $symbol;
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
}