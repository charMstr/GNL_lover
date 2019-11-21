/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_tests_utils.h                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/18 21:07:18 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/21 02:00:31 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_TESTS_UTILS_H
# define GET_NEXT_LINE_TESTS_UTILS_H

# include <assert.h>
# include <stdio.h>
# include <fcntl.h>
# include <sys/stat.h>
# include <unistd.h>

void	my_ft_putstr_fd(char *s, int fd);
size_t	my_ft_strlen(const char *s);
void	my_ft_putnbr_fd(int n, int fd);
void	my_ft_putchar_fd(char c, int fd);
void	*fake_malloc(size_t size);

#endif
