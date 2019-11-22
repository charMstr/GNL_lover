/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_STDIN_FILENO.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 04:53:43 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/22 04:53:46 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line.h"
#include "../copy_in_here_GNL_files/GNL_TESTS.h"

int	main()
{
	char	*line;
	int		result;
	char 	buf[BUFFER_SIZE + 1];

	line = NULL;
	result = 1;
	my_ft_putstr_fd("\n\n\t\t\tlets see how your GNL behaves with the STDIN_FILENO:\n", 1);
	while (result > 0)
	{
		result = get_next_line(STDIN_FILENO, &line);
		if (result != -1)
		{
			my_ft_putstr_fd(line, 1);
			my_ft_putchar_fd('\n', 1);
		}
		free(line);
	}
	my_ft_putstr_fd("<--------END\nyour GNL returned:", 1);
	my_ft_putnbr_fd(result, 1);
	my_ft_putstr_fd("\n\n\t\t\tnow compare with read behavior:\n", 1);
	result = 1;
	while (result > 0)
	{
		result = read(STDIN_FILENO, buf, BUFFER_SIZE);
		if (result != -1)
		{
			buf[result] = '\0';
			my_ft_putstr_fd(buf, 1);
		}
		if (result && buf[result - 1] == '\n')
			result = 0;
	}
	my_ft_putstr_fd("<--------END\n", 1);
	my_ft_putnbr_fd(result, 1);
	my_ft_putstr_fd("\n", 1);
	return (0);
}

