class Board{
    
    private int $n = 3;

    public function __construct(){

    }

    public function set(Point $p) : void{

    }

    public function get(Point $p): string{

    }

    public function checkWin(): bool{
        return false;

    }

    public function isValidPoint(Point $p): bool{
        return $p->getX() < $this->$n && $p->getY() < $this->$n;
    }
}