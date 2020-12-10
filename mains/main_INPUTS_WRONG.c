/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_INPUTS_WRONG.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 04:53:26 by charmstr          #+#    #+#             */
/*   Updated: 2020/12/10 18:39:38 by arguilla         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line.h"
#include "../copy_in_here_GNL_files/GNL_TESTS.h"

int	main(int argc, char *argv[])
{
	int 	fd_test_me;
	char	*line;

	line = NULL;
	if (argc != 2)
	{
		my_ft_putstr_fd("failed to provide the file to be opened as arg\n", 2);
		return (0);
	}
	if((fd_test_me = open(argv[1], O_RDONLY)) == -1)
	{
		my_ft_putstr_fd("failed to open", 2);
		my_ft_putstr_fd(argv[1], 2);
		my_ft_putstr_fd("filedescriptor.\n", 2);
		return (0);
	}
	if (BUFFER_SIZE == 0)
		assert(-1 == get_next_line(fd_test_me, &line));
	else
	{
		assert(-1 == get_next_line(-1, &line));
		free(line);
		line = NULL;
		assert(-1 == get_next_line(-42, &line));
		free(line);
		line = NULL;
		assert(-1 == get_next_line(42, &line));
		free(line);
		line = NULL;
		assert(-1 == get_next_line(42, NULL));
		free(line);
		line = NULL;
		assert(-1 == get_next_line(fd_test_me, NULL));
	}
	free(line);
	line = NULL;
	close(fd_test_me);
	return (0);
}
