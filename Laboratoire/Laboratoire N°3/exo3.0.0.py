"""
1 2 3
4 5 6
7 8 9
"""

class TicTacToe():
    def __init__(self):
        self.board = {1: '/', 2: '/', 3: '/', 4: '/', 5: '/', 6: '/', 7: '/', 8: '/', 9: '/'}

    def put_symbol(self, square, symbol):
        try:
            if square in self.board:
                if self.board[square] == '/':
                    self.board[square] = symbol
                    return self.board
                else:
                    raise SquareNotEmptyError(square, self.board[square])
            else:
                raise SquareNotFoundError(square)
        except (SquareNotFoundError, SquareNotEmptyError) as e:
            print(e)

    def game_finished(self):
        combinations = [
            (1, 2, 3), (4, 5, 6), (7, 8, 9),    # lignes
            (1, 4, 7), (2, 5, 8), (3, 6, 9),    # colonnes
            (1, 5, 9), (3, 5, 7)                # diagonales
        ]

        for combo in combinations:
            if self.board[combo[0]] != '/' and self.board[combo[0]] == self.board[combo[1]] == self.board[combo[2]]:
                return True, f"Le joueur '{self.board[combo[0]]}' a gagné !"

        if all(value != '/' for value in self.board.values()):
            return True, "Match nul !"

        return False, "Le jeu continue."

    def display_board(self):
        for i in range(1, 10, 3):
            print(self.board[i], self.board[i+1], self.board[i+2])


class SquareNotEmptyError(Exception):
    def __init__(self, square, content):
        self.square = square
        self.content = content
        super().__init__(f"La case {self.square} n'est pas vide, elle contient : {self.content}")

class SquareNotFoundError(Exception):
    def __init__(self, square):
        self.square = square
        super().__init__(f"La case {self.square} n'existe pas")

jeu = False
board = TicTacToe()

while(not jeu):
    case = 0
    while case not in [1, 2, 3, 4, 5, 6, 7, 8, 9]:
        case = int(input("Entrez votre case (1-9) : "))

    symbol = "/"
    while symbol != "X" and symbol != "O":
        symbol = input("Entrez votre symbol (X/O) : ")

    board.put_symbol(case, symbol)
    jeu, message = board.game_finished()
    print(message)
    board.display_board()