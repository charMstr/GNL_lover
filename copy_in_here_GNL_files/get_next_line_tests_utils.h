/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_tests_utils.h                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/18 21:07:18 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/21 01:14:13 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_TEST_UTILS_H
# define GET_NEXT_LINE_TEST_UTILS_H

# include "get_next_line.h"

# include <assert.h>
# include <stdio.h>
# include <fcntl.h>
# include <sys/stat.h>

void	my_ft_putstr_fd(char *s, int fd);
size_t	my_ft_strlen(const char *s);
void	my_ft_putnbr_fd(int n, int fd);
void	my_ft_putchar_fd(char c, int fd);

#endif
