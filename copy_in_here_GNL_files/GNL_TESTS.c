/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   GNL_TESTS.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/22 03:54:29 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/22 03:57:18 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "GNL_TESTS.h"

void	*fake_malloc(size_t size)
{
	size = (size_t)size;
	return (NULL);
}

void	my_ft_putstr_fd(char *s, int fd)
{
	if (!s)
		return ;
	if (write(fd, s, my_ft_strlen(s)) == -1)
		write(2, s, my_ft_strlen(s));
}

size_t	my_ft_strlen(const char *s)
{
	size_t i;

	i = 0;
	while (s[i])
		i++;
	return (i);
}

void	my_ft_putnbr_fd(int n, int fd)
{
	if (n < 0)
	{
		my_ft_putchar_fd('-', fd);
		if (n < -9)
			my_ft_putnbr_fd(-(n / 10), fd);
	}
	else if (n > 9)
		my_ft_putnbr_fd(n / 10, fd);
	(n > 0) ? my_ft_putchar_fd(n % 10 + '0', fd) \
		: my_ft_putchar_fd(-(n % 10) + '0', fd);
}

void	my_ft_putchar_fd(char c, int fd)
{
	if (write(fd, &c, 1) == -1)
		write(2, &c, 1);
}
