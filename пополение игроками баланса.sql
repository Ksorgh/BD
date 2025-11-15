#пополения игроками баланса
select 
	`amount` as 'Сумма', `player_name` as 'Никнейм',`steam_id` as 'SteamID64', `transaction_date` as 'Дата'
from transactions
natural join players
where `amount` > 0;