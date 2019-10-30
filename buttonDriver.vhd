

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity buttonDriver is
    Port ( PushButtons : in STD_LOGIC_VECTOR (4 downto 0);
           uhr : in std_logic;
           halfclock : in std_logic;
           Clickbuttons : out std_logic_vector(4 downto 0));
end buttonDriver;

architecture Behavioral of buttonDriver is

type modes is (noPush, clickcatcher, holding);
signal currentmode, nextmode: modes;

begin

process (uhr)
begin

if (rising_edge(uhr)) then
    currentmode <= nextmode;
end if;
end process;

process (nextmode)
begin
if (rising_edge(Halfclock)) then

    case currentmode is 
        
        when noPush =>
            
            if (PushButtons = "00000") then
                nextmode <= noPush;    
            else
                nextmode <= clickcatcher;
            end if;
            
        when clickcatcher =>
                                                               
            clickbuttons <= PushButtons;
            nextmode <= holding;
        
        when holding =>
            clickbuttons <= "00000";
            if (PushButtons = "00000") then
                nextmode <= noPush;   
            else
                nextmode <= holding;
            end if;
    end case;
end if;
end process;





end Behavioral;
