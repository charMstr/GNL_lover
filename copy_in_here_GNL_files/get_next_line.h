/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 16:14:58 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/20 19:47:01 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

# include <stdlib.h>
# include <sys/types.h>
# include <sys/uio.h>
# include <unistd.h>

typedef struct		s_fd
{
	int				fd;
	char			*rest;
	int				len_rest;
	int				len_line;
	int				eof;
	struct s_fd		*next;
}					t_fd;

# define ADD 1
# define REMOVE 0

# define TRICKY 2

# define END_LINE_CHAR '\n'

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 32
# endif

t_fd				*new_link(int fd);
t_fd				*manage_link(int fd, t_fd	**list, int add);
int					get_next_line(int fd, char **line);
int					to_read_or_not_to_read(t_fd *link, char **line);
int					update_strings(char **line, char *parse_me, t_fd *link, \
		int tricky);
int					update_rest(char *str, t_fd *link, int start, int old_len);
int					update_line(char **line, char *str2, t_fd *link, \
		int *found);

#endif
