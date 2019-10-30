


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Top_Pokemon is
    Port ( Uhr : in STD_LOGIC;
           PushButtons : in STD_LOGIC_VECTOR (4 downto 0);
           Hsync, Vsync : out std_logic;
           PPAliveStatus : out std_logic_vector(3 downto 0);
           VgaR, VgaB, VgaG : out std_logic_vector(3 downto 0));
end Top_Pokemon;

architecture Behavioral of Top_Pokemon is

    component Vga
         Port ( Uhr : in STD_LOGIC;
                Rin, Bin, Gin : in std_logic_vector(3 downto 0);
                Hsync, Vsync, display, Halfclock : out std_logic;
                VgaR, VgaB, VgaG : out std_logic_vector(3 downto 0);
                pixel_X : out std_logic_vector(10 downto 0);
                pixel_Y : out std_logic_vector(9 downto 0));  
    end component;
    
    component VideoGame
        Port (Clickbuttons : in STD_LOGIC_VECTOR (4 downto 0);
                display, Halfclock : in std_logic;
                pokemonFramer: in std_logic_vector(8 downto 0);
                Rin, Bin, Gin : out std_logic_vector(3 downto 0);
                Pokemonchooser : in std_logic_vector(3 downto 0);
                T1P1: in std_logic_vector(8 downto 0);
                T1P2: in std_logic_vector(8 downto 0);
                T2P1: in std_logic_vector(8 downto 0);
                T2P2: in std_logic_vector(8 downto 0);
                ssingle : in std_logic;
                Winner : in std_logic;
                Pokemonnumbers : in std_logic_vector(2 downto 0);
                ddamage : in std_logic;
                sschaden : in std_logic_vector(4 downto 0);
                angriff : in std_logic_vector(2 downto 0);
                PAliveStatus : in std_logic_vector(3 downto 0);
                PokemonStats : in std_logic_vector(19 downto 0);
                menu : in STD_LOGIC_VECTOR (2 downto 0);
                Bmenu : in STD_LOGIC_VECTOR (2 downto 0);
                pixel_X : in std_logic_vector(10 downto 0);
                pixel_Y : in std_logic_vector(9 downto 0));
    end component;
    
    component buttonDriver
        Port ( PushButtons : in STD_LOGIC_VECTOR (4 downto 0);
               uhr : in std_logic;
               halfclock : in std_logic;
               Clickbuttons : out std_logic_vector(4 downto 0));
    end component;
    
    component LogicGame
        Port ( menu : out STD_LOGIC_VECTOR (2 downto 0);
               Bmenu : out STD_LOGIC_VECTOR (2 downto 0);
               Pokemonchooser : out std_logic_vector(3 downto 0);
               pokemonFramer: out std_logic_vector(8 downto 0):="000000000";
               PokemonStats : out std_logic_vector(19 downto 0);
               T1P1: out std_logic_vector(8 downto 0);
               ssingle : out std_logic;
               Pokemonnumbers : out std_logic_vector(2 downto 0);
               T1P2: out std_logic_vector(8 downto 0);
               T2P1: out std_logic_vector(8 downto 0);
               T2P2: out std_logic_vector(8 downto 0);
               angriff : out std_logic_vector(2 downto 0);
               sschaden : out std_logic_vector(4 downto 0);
               ddamage : out std_logic;
               Winner : out std_logic;
               PAliveStatus : out std_logic_vector(3 downto 0);
               Halfclock : in std_logic;
               Clickbuttons : in std_logic_vector(4 downto 0));
    end component; 
    
    signal ssingle : std_logic;
    signal Pokemonnumbers : std_logic_vector(2 downto 0);
    signal sschaden : std_logic_vector(4 downto 0);
    signal ddamage : std_logic;
    signal angriff : std_logic_vector(2 downto 0);
    signal Winner : std_logic;
    signal PAliveStatus : std_logic_vector(3 downto 0);
    signal T1P1 : std_logic_vector (8 downto 0);
    signal T1P2 : std_logic_vector (8 downto 0);
    signal T2P1 : std_logic_vector (8 downto 0);
    signal T2P2 : std_logic_vector (8 downto 0);
    signal Bmenu : std_logic_vector(2 downto 0);
    signal pokemonFramer: std_logic_vector(8 downto 0);
    signal PokemonStats : std_logic_vector(19 downto 0);
    signal Pokemonchooser : std_logic_vector(3 downto 0);
    signal menu : std_logic_vector(2 downto 0);
    signal Clickbuttons : std_logic_vector(4 downto 0);
    signal Halfclock : std_logic;
    signal display : std_logic;
    signal Rin, Bin, Gin :  std_logic_vector(3 downto 0);
    signal pixel_X :  std_logic_vector(10 downto 0);
    signal pixel_Y :  std_logic_vector(9 downto 0);
    
begin

PPAliveStatus <= PAliveStatus;
low_Vga : Vga PORT MAP (Uhr => Uhr, Rin => Rin, Bin => Bin, Gin => Gin, Hsync => Hsync, Vsync => Vsync, display => display, Halfclock => Halfclock, VgaR => VgaR, VgaB => VgaB, VgaG => VgaG, pixel_X => pixel_X, pixel_Y => pixel_Y);
low_VideoGame : VideoGame PORT MAP (ssingle => ssingle,Pokemonnumbers =>Pokemonnumbers, angriff => angriff, sschaden => sschaden , ddamage => ddamage, winner => winner, PAliveStatus => PAliveStatus, T1P1 => T1P1, T1P2 => T1P2, T2P1 => T2P1, T2P2 => T2P2,Bmenu => Bmenu, pokemonFramer => pokemonFramer, PokemonStats => PokemonStats, Pokemonchooser => Pokemonchooser, Clickbuttons => Clickbuttons, display => display , Halfclock => Halfclock ,Rin => Rin, Bin => Bin, Gin => Gin, menu => menu, pixel_X => pixel_X, pixel_Y => pixel_Y);
low_buttonDriver : buttondriver PORT MAP (halfclock => halfclock,Pushbuttons => Pushbuttons, uhr => uhr, Clickbuttons => Clickbuttons);
low_LogicGame : LogicGame PORT MAP (ssingle => ssingle, Pokemonnumbers =>Pokemonnumbers,angriff => angriff, sschaden => sschaden, ddamage => ddamage, T1P1 => T1P1, T1P2 => T1P2,  T2P1 => T2P1, T2P2 => T2P2,winner => winner ,PAliveStatus => PAliveStatus ,Bmenu => Bmenu, pokemonFramer => pokemonFramer, Halfclock => Halfclock ,PokemonStats => PokemonStats, Pokemonchooser => Pokemonchooser, menu => menu, Clickbuttons => clickbuttons);

end Behavioral;
