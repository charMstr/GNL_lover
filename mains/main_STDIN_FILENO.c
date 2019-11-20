/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_STDIN_FILENO.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 19:50:33 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/19 16:40:52 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line_tests_utils.h"
#include "../copy_in_here_GNL_files/get_next_line.h"

int	main()
{
	char	*line;
	int		result;
	char 	buf[BUFFER_SIZE + 1];

	line = NULL;
	result = 1;
	ft_putstr_fd("\n\n\t\t\tlets see how your GNL behaves with the STDIN_FILENO:\n", 1);
	while (result > 0)
	{
		result = get_next_line(STDIN_FILENO, &line);
		if (result != -1)
		{
			ft_putstr_fd(line, 1);
			ft_putchar_fd('\n', 1);
		}
	}
	ft_putstr_fd("<--------END\nyour GNL returned:", 1);
	ft_putnbr_fd(result, 1);
	ft_putstr_fd("\n\n\t\t\tnow compare with read behavior:\n", 1);
	result = 1;
	while (result > 0)
	{
		result = read(STDIN_FILENO, buf, BUFFER_SIZE);
		if (result != -1)
		{
			buf[result] = '\0';
			ft_putstr_fd(buf, 1);
		}
		if (result && buf[result - 1] == '\n')
			result = 0;
	}
	ft_putstr_fd("<--------END\n", 1);
	ft_putnbr_fd(result, 1);
	ft_putstr_fd("\n", 1);
	free(line);
	return (0);
}

