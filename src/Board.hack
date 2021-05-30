use namespace HH\Lib\{C};
class Board{
    
    private int $n = 3;
    private vec<vec<string>> $board;
    private bool $is_first_o = true;
    private bool $is_first_x = true;

    public function __construct(){
        $this->board = vec[
                        vec["", "", ""], 
                        vec["", "", ""], 
                        vec["", "", ""]
                    ];
    }

    public function __toString(): string {
        $boardStr = "";
        foreach($this->board as $row){
            foreach($row as $entry){
                $boardStr." ".$entry;
            }
        }
        echo $boardStr;
        return $boardStr;
    }

    public function print(): void{
        foreach($this->board as $row){
            foreach($row as $entry){
                echo $entry."  |  ";
            }
            echo "\n";
        }
    }

    public function set(Point $p, string $symbol) : void {
        if($symbol === 'O') $this->is_first_o = true;
        else $this->is_first_x = true;

        $x = $p->getX();
        $y = $p->getY();
        $this->board[$x][$y] = $symbol;
    }


    public function get(Point $p): string{
        $x = $p->getX();
        $y = $p->getY();
        return $this->board[$x][$y];
    }

    public function isSet(Point $p): bool{
        $x = $p->getX();
        $y = $p->getY();

        return $this->board[$x][$y] !== "";
    }

    public function checkWin(): bool{
        return false;
    }

    public function isOnBoard(Point $p): bool{
        return $p->getX() < $this->n && $p->getY() < $this->n;
    }

    public function isValidPoint(Point $p, string $symbol) : bool {
        $variant = $this->isOnBoard($p);
        if(!$variant) return false;
        if(($symbol === 'O' && $this->is_first_o) || ($symbol === 'X' && $this->is_first_x)) return $variant;
        else{
            $x = vec[1,-1, 0,  0, 1, -1, 1, -1];
            $y = vec[0, 0, 1, -1, 1, -1, -1, 1];

            // check if adjacent piece exists
            $size = C\count($x);
            for($i = 0; $i < $size; $i++){
                $j = $p->getX();
                $k = $p->getY();
                $x_adj = $x[$i] + $j; 
                $y_adj = $y[$i] + $k; 

                $adj_point = new Point($x_adj, $y_adj);
                if($this->isOnBoard($adj_point) && $this->get($adj_point) === $symbol) return true;
            }

            return false;
        }        

    }
}