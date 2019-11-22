/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 04:52:37 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/22 04:53:14 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line.h"
#include "../copy_in_here_GNL_files/GNL_TESTS.h"

int	main(int argc, char *argv[])
{
	int 	fd_test_me;
	int		fd_user_output;
	char	*line;
	int		result;

	line = NULL;
	result = 1;
	if (argc != 2)
	{
		my_ft_putstr_fd("failed to provide the file to be opened as arg\n", 2);
		return (0);
	}
	if((fd_user_output = open("./user_output", O_RDWR | O_CREAT |  O_TRUNC, 0644)) == -1)
	{
		my_ft_putstr_fd("failed to open ./user_output filedescriptor\n", 2);
		return (0);
	}
	if((fd_test_me = open(argv[1], O_RDONLY)) == -1)
	{
		my_ft_putstr_fd("failed to open", 2);
		my_ft_putstr_fd(argv[1], 2);
		my_ft_putstr_fd("filedescriptor.\n", 2);
		return (0);
	}
	while (result > 0)
	{
		result = get_next_line(fd_test_me, &line);
		if (result != -1)
		{
			my_ft_putstr_fd(line, fd_user_output);
			if (result)
				my_ft_putchar_fd('\n', fd_user_output);
		}
		free(line);
	}
	close(fd_test_me);
	close(fd_user_output);
	return (0);
}
