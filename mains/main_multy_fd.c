/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_multy_fd.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 04:54:20 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/22 04:54:25 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../copy_in_here_GNL_files/get_next_line.h"
#include "../copy_in_here_GNL_files/GNL_TESTS.h"

int	break_and_exit(void)
{
	my_ft_putstr_fd("get_next_line returned a -1 at some point\n", 2);
	return (-1);
}

int get_fd(char **line, int fd, int fd_user_output)
{
	int result;

	result = get_next_line(fd, line);
	if (result == -1)
	{
		free(line);
		return (break_and_exit());
	}
	my_ft_putstr_fd(*line, fd_user_output);
	my_ft_putchar_fd('\n', fd_user_output);
	free(*line);
	return (result);
}

int	open_fd(char *name_file)
{
	int fd;

	if((fd = open(name_file, O_RDONLY)) == -1)
	{
		my_ft_putstr_fd("failed to open", 2);
		my_ft_putstr_fd(name_file, 2);
		my_ft_putstr_fd("filedescriptor.\n", 2);
		return (-1);
	}
	return (fd);
}

int	main(int argc, char *argv[])
{
	int 	fd1;
	int 	fd2;
	int 	fd3;
	int 	fd4;
	int		fd_user_output;
	char	*line;
	int		i;
	int		result;

	line = NULL;
	result = 1;
	if (argc != 5)
	{
		my_ft_putstr_fd("failed to provide the files to be opened as arg (need 4)\n", 2);
		return (0);
	}
	if((fd_user_output = open("./user_output", O_RDWR | O_CREAT |  O_TRUNC, 0644)) == -1)
	{
		my_ft_putstr_fd("failed to open ./user_output filedescriptor\n", 2);
		return (0);
	}
	if ((fd1 = open_fd(argv[1])) == -1)
		return (0);
	if ((fd2 = open_fd(argv[2])) == -1)
		return (0);
	if ((fd3 = open_fd(argv[3])) == -1)
		return (0);
	if ((fd4 = open_fd(argv[4])) == -1)
		return (0);
	i = 0;
	while (i < 11)
	{
		assert(-1 != (result = get_fd(&line, fd1, fd_user_output)));
		assert(-1 != (result = get_fd(&line, fd2, fd_user_output)));
		assert(-1 != (result = get_fd(&line, fd3, fd_user_output)));
		assert(-1 != (result = get_fd(&line, fd4, fd_user_output)));
		i++;
	}
	system("cat ./user_output");
	close(fd_user_output);
	close(fd1);
	close(fd2);
	close(fd3);
	close(fd4);
	return (0);
}
