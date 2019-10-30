
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity LogicGame is
    Port ( menu : out STD_LOGIC_VECTOR (2 downto 0);
           Bmenu : out STD_LOGIC_VECTOR (2 downto 0);
           Pokemonchooser : out std_logic_vector(3 downto 0);
           pokemonFramer: out std_logic_vector(8 downto 0):="000000000";
           PokemonStats : out std_logic_vector(19 downto 0);
           T1P1: out std_logic_vector(8 downto 0);
           T1P2: out std_logic_vector(8 downto 0);
           T2P1: out std_logic_vector(8 downto 0);
           T2P2: out std_logic_vector(8 downto 0);
           ssingle : out std_logic;
           Ddamage : out std_logic;
           Pokemonnumbers: out std_logic_vector(2 downto 0);
           Sschaden : out std_logic_vector(4 downto 0);
           Angriff : out std_logic_vector (2 downto 0);
           Winner : out std_logic;
           PAliveStatus : out std_logic_vector(3 downto 0);
           Halfclock : in std_logic;
           Clickbuttons : in std_logic_vector(4 downto 0));
end LogicGame;

architecture Behavioral of LogicGame is

signal Battlemenu: std_logic_vector(2 downto 0):="000";
signal Logicmenu : std_logic_vector(2 downto 0):="000";
signal AliveStatus : std_logic_vector(3 downto 0):="1111";
signal tempAliveStatus : std_logic;
signal tempid : std_logic_vector(3 downto 0);
signal nextmenu : std_logic_vector(2 downto 0);

type team1 is array (0 to 1, 0 to 4) of std_logic_vector(4 downto 0);
type team2 is array (0 to 1, 0 to 4) of std_logic_vector(4 downto 0);
type tempteam is array (0 to 4) of std_logic_vector(4 downto 0);

type Pokemons is array (0 to 8, 0 to 4) of std_logic_vector(4 downto 0);
--Pokemon ID (0 to 14)                  --0 Austoss     --7 Magmar      
--Pokemon stats (0 to 4)                --1 Garados     --8 Gallopa     
    --0-Type                            --2 Turtok         
    --1-HP                              --3 Bisaflor    
    --2-Attack                          --4 Kokowei     
    --3-Defense                         --5 Sarzenia    
    --4-Speed                           --6 Glurak      
                                                        
                                                        
signal Pokemontempteam : tempteam;

signal PokemonTeam1 : team1;

signal PokemonTeam2 : team2;

constant PokemonDatas : Pokemons :=(
--Austoss
 ("00001","11111","01010","01111","00110"),
--Garados
 ("00001","11111","01110","01100","01001"),
--Turtok
 ("00001","11100","01100","01101","01100"),
--Bisaflor
 ("00010","11100","01100","01100","01100"),
--Kokowei
 ("00010","11100","01010","00111","01101"),
--Sarzenia
 ("00010","11011","01110","00111","01110"),
--Glurak
 ("00100","11100","01110","00111","01110"),
--Magmar
 ("00100","11010","01100","01000","01011"),
--Gallopa
 ("00100","11011","01100","01001","01100"));

signal schaden : std_logic_vector(4 downto 0);
signal selectedpokemon : integer range 0 to 8:=0;
signal teamPokemonNumber : integer range 0 to 4:= 0;
signal computerPokemon : integer range 0 to 8:=0;
signal T1p1id : std_logic_vector(3 downto 0);
signal T1p2id : std_logic_vector(3 downto 0);
signal T2p1id : std_logic_vector(3 downto 0);
signal T2p2id : std_logic_vector(3 downto 0);
signal Attackerid : std_logic_vector(3 downto 0);
signal Defenserid : std_logic_vector(3 downto 0);
signal damage: std_logic;
signal change: std_logic;
signal single: std_logic;

begin
ssingle <= single;
Pokemonnumbers <= teamPokemonNumber + "000";
Ddamage <= damage;
Sschaden <= schaden;
computerPokemon <= selectedpokemon + 3 when selectedpokemon + 3 <=8 else 0;
Pokemonchooser <= selectedpokemon + "0000";
PokemonStats(19 downto 15) <= PokemonDatas(selectedpokemon, 1)(4 downto 0);
PokemonStats(14 downto 10) <= PokemonDatas(selectedpokemon, 2)(4 downto 0);
PokemonStats(9 downto 5) <= PokemonDatas(selectedpokemon, 3)(4 downto 0);
PokemonStats(4 downto 0) <= PokemonDatas(selectedpokemon, 4)(4 downto 0);

--Health Points
T1P1(8 downto 4) <= pokemonTeam1(0,1)(4 downto 0);
T1P2(8 downto 4) <= pokemonTeam1(1,1)(4 downto 0);

T1P1(3 downto 0) <= T1p1id;
T1P2(3 downto 0) <= T1p2id;

--Health Points
T2P1(8 downto 4) <= pokemonTeam2(0,1)(4 downto 0);
T2P2(8 downto 4) <= pokemonTeam2(1,1)(4 downto 0);

T2P1(3 downto 0) <= T2p1id;
T2P2(3 downto 0) <= T2p2id;

PAliveStatus <= Alivestatus;

process (Logicmenu, Halfclock)

begin
    if (Halfclock'event and Halfclock ='1') then
    
    case Logicmenu is    
        
        --MainMenu
        when "000" =>
            
            if(clickbuttons(2) = '1') then
                logicmenu <= "001";
            
            elsif(clickbuttons(3) = '1') then
                logicmenu <= "010";
            end if;
            
        --Single Chooser
        when "001" =>
            
            single <= '1';
            if(clickbuttons(4)= '1') then
                logicmenu <= "000";
                selectedpokemon <= 0;
                pokemonframer <= "000000000"; 
                teamPokemonNumber <= 0;    
                   
            elsif(clickbuttons(2) = '1') then
                if(selectedpokemon = 0) then selectedpokemon <= 8;
                else selectedpokemon <= selectedpokemon - 1;
                end if;
                
            elsif(clickbuttons(3) = '1') then
                if(selectedpokemon = 8) then selectedpokemon <= 0;
                else selectedpokemon <= selectedpokemon + 1;
                end if;
                
            elsif(clickbuttons(0) = '1') then
                
                if(teamPokemonNumber < 2) then
                
                pokemonFramer(selectedpokemon) <= '1';
                pokemonTeam1(teamPokemonNumber, 0) (4 downto 0)<= PokemonDatas(selectedpokemon, 0)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 1) (4 downto 0)<= PokemonDatas(selectedpokemon, 1)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 2) (4 downto 0)<= PokemonDatas(selectedpokemon, 2)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 3) (4 downto 0)<= PokemonDatas(selectedpokemon, 3)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 4) (4 downto 0)<= PokemonDatas(selectedpokemon, 4)(4 downto 0);
             
                
                pokemonteam2(teamPokemonNumber, 0) (4 downto 0)<= PokemonDatas(computerPokemon, 0)(4 downto 0);
                pokemonteam2(teamPokemonNumber, 1) (4 downto 0)<= PokemonDatas(computerPokemon, 1)(4 downto 0);
                pokemonteam2(teamPokemonNumber, 2) (4 downto 0)<= PokemonDatas(computerPokemon, 2)(4 downto 0);
                pokemonteam2(teamPokemonNumber, 3) (4 downto 0)<= PokemonDatas(computerPokemon, 3)(4 downto 0);
                pokemonteam2(teamPokemonNumber, 4) (4 downto 0)<= PokemonDatas(computerPokemon, 4)(4 downto 0);
                          
                if(teamPokemonNumber = 0) then
                    T1p1id <= selectedpokemon + "0000";
                    T2p1id <= computerPokemon + "0000";
                
                elsif(teamPokemonNumber = 1) then
                    T1p2id <= selectedpokemon + "0000";
                    T2p2id <= computerPokemon + "0000";
                    
                end if;
               
                teamPokemonNumber <= teamPokemonNumber + 1;
                
                else
                teamPokemonNumber <= 0;
                logicmenu <= "011";
                
                end if;
                
            end if;
        
        --Multi Chooser       
        when "010" =>
            single <= '0';
            if(clickbuttons(4) = '1') then
                logicmenu <= "000";
                selectedpokemon <= 0;
                pokemonframer <= "000000000"; 
                teamPokemonNumber <= 0; 
            
            elsif(clickbuttons(2) = '1') then
                if(selectedpokemon = 0) then selectedpokemon <= 8;
                else selectedpokemon <= selectedpokemon - 1;
                end if;                
            elsif(clickbuttons(3) = '1') then
                if(selectedpokemon = 8) then selectedpokemon <= 0;
                else selectedpokemon <= selectedpokemon + 1;
                end if; 
                        
            elsif(clickbuttons(0) = '1') then
                             
                if(teamPokemonNumber < 2) then
                
                
                pokemonFramer(selectedpokemon) <= '1';                
                pokemonTeam1(teamPokemonNumber, 0) (4 downto 0)<= PokemonDatas(selectedpokemon, 0)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 1) (4 downto 0)<= PokemonDatas(selectedpokemon, 1)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 2) (4 downto 0)<= PokemonDatas(selectedpokemon, 2)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 3) (4 downto 0)<= PokemonDatas(selectedpokemon, 3)(4 downto 0);
                pokemonTeam1(teamPokemonNumber, 4) (4 downto 0)<= PokemonDatas(selectedpokemon, 4)(4 downto 0);
                
                    if(teamPokemonNumber = 0) then
                        T1p1id <= selectedpokemon + "0000";
                                        
                    elsif(teamPokemonNumber = 1) then
                        T1p2id <= selectedpokemon + "0000";
                   
                    end if;
                
                teamPokemonNumber <= teamPokemonNumber + 1;
                
                elsif(teamPokemonnumber < 4) then
                
                pokemonFramer(selectedpokemon) <= '1';
                pokemonteam2(teamPokemonNumber - 2, 0) (4 downto 0)<= PokemonDatas(selectedpokemon, 0)(4 downto 0);
                pokemonteam2(teamPokemonNumber - 2, 1) (4 downto 0)<= PokemonDatas(selectedpokemon, 1)(4 downto 0);
                pokemonteam2(teamPokemonNumber - 2, 2) (4 downto 0)<= PokemonDatas(selectedpokemon, 2)(4 downto 0);
                pokemonteam2(teamPokemonNumber - 2, 3) (4 downto 0)<= PokemonDatas(selectedpokemon, 3)(4 downto 0);
                pokemonteam2(teamPokemonNumber - 2, 4) (4 downto 0)<= PokemonDatas(selectedpokemon, 4)(4 downto 0);
                
                    if(teamPokemonNumber = 2) then
                        T2p1id <=  selectedpokemon + "0000"; 
                                       
                    elsif(teamPokemonNumber = 3) then
                        T2p2id <= selectedpokemon + "0000";
                        
                    end if;
                
                teamPokemonNumber <= teamPokemonNumber + 1;
                                
                else
                teamPokemonNumber <= 0;
                logicmenu <= "011";
                                
                end if;                    
            end if;
            
        --SingleFight or MultiFight
        when "011" =>
            
            case Battlemenu is
                
                --First Attack Determiner
                when "000" =>
                
                if(clickbuttons(0) = '1') then
                    if(pokemonTeam1(0, 4) (4 downto 0) >= pokemonTeam2(0, 4) (4 downto 0)) then
                        Battlemenu <= "101";
                        nextmenu <= "001";
                        Attackerid <= t1p1id;
                        Defenserid <= t2p1id;
     
                    else
                        Attackerid <= t2p1id;
                        Defenserid <= t1p1id;
                        nextmenu <= "011"; 
                        Battlemenu <= "101";
                    end if;
                 end if;
                --First Chooses Attack
                when "001" =>
                    
                    
                    --type Attack
                    if(clickbuttons(2) = '1') then
                        
                        if(Attackerid < 3) then Angriff <= "001";
                        elsif(Attackerid > 2 and Attackerid < 6) then Angriff <= "010";
                        elsif(Attackerid > 5 and Attackerid < 9) then Angriff <= "011"; end if;
                        
                        
                        if(damage = '0') then 
                        schaden <= (pokemonteam1(0,2) - pokemonteam2(0,3)) + 5;
                        else 
                        schaden <= (pokemonteam1(0,2) - pokemonteam2(0,3)) + 14;  
                        end if;
                        Battlemenu <= "110";
                        
                    --normal Attack    
                    elsif(clickbuttons(3) = '1') then
                        Angriff <= "000";
                        schaden <= (pokemonteam1(0,2) - pokemonteam2(0,3)) + 9;  
                        
                        Battlemenu <= "110";
                    end if;
                    
                    --Change pokemon
                    if((clickbuttons(1) = '1' and alivestatus(0) = '1' and alivestatus(1) = '1') or alivestatus(0) = '0') then
                        Pokemontempteam(0) <= pokemonteam1(0,0);
                        Pokemontempteam(1) <= pokemonteam1(0,1);
                        Pokemontempteam(2) <= pokemonteam1(0,2);
                        Pokemontempteam(3) <= pokemonteam1(0,3);
                        Pokemontempteam(4) <= pokemonteam1(0,4);
                        tempid <= T1p2id;
                        tempAliveStatus <= alivestatus(0);                        
                        change <= '1';
                        Angriff <= "111";
                        Battlemenu <= "110";
                                    
                      end if;
                
                --Processor      
                when "110" =>
                if(change = '1') then
                        pokemonteam1(0,0) <= pokemonteam1(1,0);
                        pokemonteam1(0,1) <= pokemonteam1(1,1);
                        pokemonteam1(0,2) <= pokemonteam1(1,2);
                        pokemonteam1(0,3) <= pokemonteam1(1,3);
                        pokemonteam1(0,4) <= pokemonteam1(1,4);
                        
                        pokemonteam1(1,0) <= Pokemontempteam(0);
                        pokemonteam1(1,1) <= Pokemontempteam(1);
                        pokemonteam1(1,2) <= Pokemontempteam(2);
                        pokemonteam1(1,3) <= Pokemontempteam(3);
                        pokemonteam1(1,4) <= Pokemontempteam(4);
                                         
                        T1p2id <= T1p1id;
                        T1p1id <= tempid;
    
                        alivestatus(0) <= alivestatus(1);
                        alivestatus(1) <= tempAliveStatus;
                        change <= '0';
                        Battlemenu <= "010";
               else
                        
                if(pokemonteam2(0,1) < schaden) then 
                    alivestatus(2) <= '0';
                    pokemonteam2(0,1) <= "00000"; 
                    if(alivestatus(3) <= '0') then
                        logicmenu <= "101"; winner <= '0';
                    else
                    schaden <= "00000"; Battlemenu <= "011"; end if;  
                else pokemonteam2(0,1) <= pokemonteam2(0,1)- schaden; Battlemenu <= "010";end if;  end if;      
               
                    
                --Damage Screen(Attack, Effective)
                when "010" =>          
                
                    if(clickbuttons(0) = '1') then 
                        if( alivestatus(3 downto 2) = "00") then 
                            logicmenu <= "101";
                            winner <= '0'; -- First team wins
                        else
                            Attackerid <= t2p1id;
                            Defenserid <= t1p1id;
                            
                            nextmenu <= "011";
                            Battlemenu <= "101"; 
                        end if;
                    end if;
                    
                --Second Choses Attack
                when "011" =>                 
                    
                    if(single = '0') then
                    
                    --type Attack
                    if(clickbuttons(2) = '1') then
                        
                        if(Attackerid < 3) then Angriff <= "001";
                        elsif(Attackerid > 2 and Attackerid < 6) then Angriff <= "010";
                        elsif(Attackerid > 5 and Attackerid < 9) then Angriff <= "011"; end if;
                        
                        if(damage = '0') then 
                        schaden <= (pokemonteam2(0,2) - pokemonteam1(0,3)) + 5;
                        else schaden <=  (pokemonteam2(0,2) - pokemonteam1(0,3)) + 14;
                        end if;
                        
                        
                        Battlemenu <= "111";
                        
                    --normal Attack    
                    elsif(clickbuttons(3) = '1') then
                        angriff <= "000";
                        schaden <=  (pokemonteam2(0,2) - pokemonteam1(0,3)) + 9;
                        
                        Battlemenu <= "111";
                    end if;
                    
                    --Change pokemon
                    if((clickbuttons(1) = '1'  and alivestatus(2) = '1' and alivestatus(3) = '1')  or alivestatus(2) = '0') then
                        Pokemontempteam(0) <= pokemonteam2(0,0);
                        Pokemontempteam(1) <= pokemonteam2(0,1);
                        Pokemontempteam(2) <= pokemonteam2(0,2);
                        Pokemontempteam(3) <= pokemonteam2(0,3);
                        Pokemontempteam(4) <= pokemonteam2(0,4);
                        tempid <= T2p2id;
                        tempAliveStatus <= alivestatus(2);
                        change <= '1'; 
                        Angriff <= "111";                                                  
                        Battlemenu <= "111";
                        
                    end if; 
                    
               else 
                    if(alivestatus(2) = '0') then
                       Pokemontempteam(0) <= pokemonteam2(0,0);
                       Pokemontempteam(1) <= pokemonteam2(0,1);
                       Pokemontempteam(2) <= pokemonteam2(0,2);
                       Pokemontempteam(3) <= pokemonteam2(0,3);
                       Pokemontempteam(4) <= pokemonteam2(0,4);
                       tempid <= T2p2id;
                       tempAliveStatus <= alivestatus(2);
                       change <= '1';                                                   
                       Battlemenu <= "111";
                    end if;
                    
                    if(damage = '0') then
                        Angriff <= "000";
                        schaden <=  (pokemonteam2(0,2) - pokemonteam1(0,3)) + 9;
                    else
                        if(Attackerid < 3) then Angriff <= "001";
                        elsif(Attackerid > 2 and Attackerid < 6) then Angriff <= "010";
                        elsif(Attackerid > 5 and Attackerid < 9) then Angriff <= "011"; end if;
                        schaden <=  (pokemonteam2(0,2) - pokemonteam1(0,3)) + 14;
                    end if;
                    
                    
                    
                    Battlemenu <= "111";
                end if;
                
                --Processor2
                when "111" => 
                    
                    if(change = '1')  then                
                    pokemonteam2(0,0) <= pokemonteam2(1,0);
                    pokemonteam2(0,1) <= pokemonteam2(1,1);
                    pokemonteam2(0,2) <= pokemonteam2(1,2);
                    pokemonteam2(0,3) <= pokemonteam2(1,3);
                    pokemonteam2(0,4) <= pokemonteam2(1,4);
                    
                    pokemonteam2(1,0) <= Pokemontempteam(0);
                    pokemonteam2(1,1) <= Pokemontempteam(1);
                    pokemonteam2(1,2) <= Pokemontempteam(2);
                    pokemonteam2(1,3) <= Pokemontempteam(3);
                    pokemonteam2(1,4) <= Pokemontempteam(4);
                    
                    T2p2id <= T2p1id;
                    T2p1id <= tempid;
                    
                    alivestatus(2) <= alivestatus(3);
                    alivestatus(3) <= tempAliveStatus;                                                    
                    change <= '0';
                    Battlemenu <= "100";
                    else
                    
                    if(pokemonteam1(0,1) < schaden) then 
                    alivestatus(0) <= '0';
                    pokemonteam1(0,1) <= "00000"; 
                    if (alivestatus(1) = '0') then
                        logicmenu <= "101"; winner <= '1';
                    else
                    Battlemenu <= "001"; schaden <= "00000"; end if;
                else pokemonteam1(0,1) <= pokemonteam1(0,1)- schaden; Battlemenu <= "100"; end if; end if;
                                        
                --Damage Screen(Attack, Effective)
                when "100" =>
                
                    if(clickbuttons(0) = '1') then 
                            Attackerid <= t1p1id;
                            Defenserid <= t2p1id;
                            
                            nextmenu <= "001";
                            Battlemenu <= "101"; 
                        end if;             
                
                --Next Stater
                when "101" =>
                    if((Attackerid > 5 and Attackerid < 9 and Defenserid > 2 and Defenserid < 6)
                        or (Attackerid < 3 and Defenserid > 5 and Defenserid < 9)
                        or (Attackerid > 2 and Attackerid < 6 and Defenserid < 3)) then damage <='1';
                    else damage <='0'; end if;
                
                
                    if(nextmenu = "000") then    Battlemenu <= "000";
                    elsif(nextmenu = "001") then Battlemenu <= "001";
                    elsif(nextmenu = "010") then Battlemenu <= "010";
                    elsif(nextmenu = "011") then Battlemenu <= "011";
                    elsif(nextmenu = "100") then Battlemenu <= "100";
                    elsif(nextmenu = "101") then Battlemenu <= "101";
                    elsif(nextmenu = "110") then Battlemenu <= "110";
                    elsif(nextmenu = "111") then Battlemenu <= "111";
                    end if;
                    
                when others =>
            end case;
        
        --Winner
        when "101" =>
            selectedpokemon <= 0;
            pokemonframer <= "000000000"; 
            teamPokemonNumber <= 0;
            alivestatus <= "1111";
            Battlemenu <= "000"; 
            if(clickbuttons(4) = '1') then
            logicmenu <= "000"; 
            end if;
            
        when others =>    
        
    end case;
    end if;
    Bmenu <= battlemenu;
    menu <= logicmenu;
end process;

end Behavioral;
