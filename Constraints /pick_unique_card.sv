// ------------------------------------------------------------------
// Author: Omkar Ashish Shelar
// ------------------------------------------------------------------
// Q: In a deck of 52 cards (4 suits with numbers from 1 to 13), return 4 cards each with unique suit and number. 

class cards_cons ; 
  rand int cards[4][13]; 
  rand int cards_sel[4] ; 
  
  // Assign the numbers 1-13 to each suit of cards.
  constraint cards_val{foreach(cards[i,j]) cards[i][j] == j+1;}
  
  constraint cards_select{foreach(cards_sel[i])cards_sel[i] inside{cards[i]}; unique{cards_sel};}
  
endclass 

module abc; 
  initial begin
    cards_cons c = new(); 
    c.randomize(); 
    $display("%0p" , c.cards_sel);
  end 
endmodule
