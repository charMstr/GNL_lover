/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_WRONG_INPUTS.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/19 17:01:27 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/20 23:38:31 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line.h"
#include "../copy_in_here_GNL_files/get_next_line_tests_utils.h"

int	main(int argc, char *argv[])
{
	int 	fd_test_me;
	char	*line;
	int		result;

	line = NULL;
	result = 1;
	argv[0] = (char *)argv[0];
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
	assert(-1 == get_next_line(-1, &line));
	free(line);
	assert(-1 == get_next_line(-42, &line));
	free(line);
	assert(-1 == get_next_line(42, &line));
	free(line);
	assert(-1 == get_next_line(42, NULL));
	free(line);
	assert(-1 == get_next_line(fd_test_me, NULL));
	free(line);
	return (0);
}
