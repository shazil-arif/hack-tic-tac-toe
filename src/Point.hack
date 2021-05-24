namespace TicTacToe\Point;
class Point{
    private int $x;
    private int $y;
    
    public function __construct(x,y){
        $this->$x = $x;
        $this->$y = $y;
    }
    
    public function __toString(): string{
        return "(".$this->$x.",".$this->$y.")";
    }
    public function getX() : int{
        return $this->$x;
    }

    public function getY(): int{
        return $this->$y;
    }
}